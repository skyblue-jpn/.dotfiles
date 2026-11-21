#!/bin/bash
# Apply Catppuccin Macchiato theme to Limine bootloader and Linux TTY.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

readonly LIMINE_THEME_FILE="${REPO_ROOT}/themes/catppuccin/limine/catppuccin-macchiato.conf"
readonly TTY_CMDLINE_FILE="${REPO_ROOT}/themes/catppuccin/tty/catppuccin-macchiato.cmdline"
readonly TTY_VTRGB_FILE="${REPO_ROOT}/themes/catppuccin/tty/catppuccin-macchiato.vtrgb"

readonly DROPIN_DIR="/etc/limine-entry-tool.d"
readonly DROPIN_FILE="${DROPIN_DIR}/10-catppuccin-tty.conf"
readonly HOOK_DIR="/etc/boot/hooks/post.d"
readonly HOOK_FILE="${HOOK_DIR}/50-catppuccin-limine-theme"
readonly VTRGB_TARGET="/etc/vtrgb"
readonly STAMP_DIR="/var/lib/limine"
readonly STAMP_FILE="${STAMP_DIR}/catppuccin-theme.stamp"

if [[ ! -f "$LIMINE_THEME_FILE" || ! -f "$TTY_CMDLINE_FILE" || ! -f "$TTY_VTRGB_FILE" ]]; then
  echo "Error: Catppuccin Limine/TTY theme files not found under ${REPO_ROOT}/themes/catppuccin/" >&2
  exit 1
fi

TTY_CMDLINE="$(tr -d '\r\n' <"$TTY_CMDLINE_FILE")"
EXPECTED_RED="$(sed -n '1p' "$TTY_VTRGB_FILE")"
EXPECTED_GRN="$(sed -n '2p' "$TTY_VTRGB_FILE")"
EXPECTED_BLU="$(sed -n '3p' "$TTY_VTRGB_FILE")"
EXPECTED_STAMP="$(sha256sum "$LIMINE_THEME_FILE" "$TTY_CMDLINE_FILE" "$TTY_VTRGB_FILE" | sha256sum | awk '{print $1}')"

patch_limine_conf() {
  local limine_conf="$1"
  [[ -f "$limine_conf" ]] || return 0

  local tmp_conf
  tmp_conf="$(mktemp)"

  awk -v theme_file="$LIMINE_THEME_FILE" -v tty_cmdline="$TTY_CMDLINE" '
    function print_theme_block(   line) {
      print "# >>> catppuccin-limine >>>"
      while ((getline line < theme_file) > 0) {
        if (line != "") print line
      }
      close(theme_file)
      print "# <<< catppuccin-limine <<<"
      theme_inserted = 1
    }
    BEGIN {
      in_block = 0
      in_entries = 0
      theme_inserted = 0
    }
    /^# >>> catppuccin-limine >>>$/ {
      in_block = 1
      if (!theme_inserted) {
        print_theme_block()
      }
      next
    }
    /^# <<< catppuccin-limine <<<$/ {
      in_block = 0
      next
    }
    in_block {
      next
    }
    !in_entries && /^[[:space:]]*\/+/ {
      if (!theme_inserted) {
        print_theme_block()
        print ""
      }
      in_entries = 1
    }
    !in_entries && /^[[:space:]]*(term_palette|term_palette_bright|term_background|term_foreground|term_background_bright|term_foreground_bright|interface_branding_colou?r|interface_help_colou?r|interface_help_colou?r_bright)[[:space:]]*:/ {
      next
    }
    in_entries && /^[[:space:]]*(kernel_)?cmdline[[:space:]]*:/ {
      gsub(/[[:space:]]+vt\.default_(red|grn|blu)=[^[:space:]]+/, "")
      $0 = $0 " " tty_cmdline
    }
    {
      print
    }
    END {
      if (!theme_inserted) {
        print_theme_block()
      }
    }
  ' "$limine_conf" >"$tmp_conf"

  if ! cmp -s "$tmp_conf" "$limine_conf"; then
    cp -p "$limine_conf" "${limine_conf}.bak" 2>/dev/null || true
    install -m 600 "$tmp_conf" "$limine_conf"
    sync -f "$limine_conf" 2>/dev/null || true
    echo "==> Applied Catppuccin Macchiato theme to ${limine_conf}."
  fi
  rm -f "$tmp_conf"
}

resolve_limine_conf() {
  local esp_path="/boot"
  if [[ -f /etc/default/limine ]]; then
    local cfg_esp
    cfg_esp="$(awk -F= '/^[[:space:]]*ESP_PATH[[:space:]]*=/ {gsub(/["[:space:]]/, "", $2); print $2; exit}' /etc/default/limine)"
    if [[ -n "$cfg_esp" ]]; then
      esp_path="$cfg_esp"
    fi
  fi
  printf '%s/limine.conf\n' "${esp_path%/}"
}

if [[ "${1:-}" == "--patch-limine-conf" ]]; then
  [[ $# -ge 2 ]] || {
    echo "Error: --patch-limine-conf requires a path" >&2
    exit 1
  }
  patch_limine_conf "$2"
  exit 0
fi

# Mode executed automatically by limine-entry-tool post.d hook
if [[ "${1:-}" == "--limine-hook" ]]; then
  limine_conf="$(resolve_limine_conf)"
  patch_limine_conf "$limine_conf"
  install -d -m 755 "$STAMP_DIR"
  printf '%s\n' "$EXPECTED_STAMP" >"$STAMP_FILE"
  chmod 644 "$STAMP_FILE"
  exit 0
fi

# Fast non-root convergence check so repeat bootstrap runs do not invoke sudo
is_converged() {
  if [[ -d /sys/module/vt/parameters ]]; then
    [[ -f "$VTRGB_TARGET" ]] && cmp -s "$TTY_VTRGB_FILE" "$VTRGB_TARGET" || return 1
    [[ "$(cat /sys/module/vt/parameters/default_red 2>/dev/null || true)" == "$EXPECTED_RED" ]] || return 1
    [[ "$(cat /sys/module/vt/parameters/default_grn 2>/dev/null || true)" == "$EXPECTED_GRN" ]] || return 1
    [[ "$(cat /sys/module/vt/parameters/default_blu 2>/dev/null || true)" == "$EXPECTED_BLU" ]] || return 1
  fi

  if [[ -f /etc/default/limine || -f /etc/limine-entry-tool.conf ]]; then
    [[ -f "$DROPIN_FILE" ]] && grep -Fq "$TTY_CMDLINE" "$DROPIN_FILE" || return 1
    if [[ -d "$HOOK_DIR" ]]; then
      [[ -x "$HOOK_FILE" ]] || return 1
    fi
    [[ -f "$STAMP_FILE" && "$(cat "$STAMP_FILE" 2>/dev/null || true)" == "$EXPECTED_STAMP" ]] || return 1
  fi

  return 0
}

if is_converged; then
  echo "==> Catppuccin Macchiato Limine & TTY themes are already applied."
  exit 0
fi

if [[ "$EUID" -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

# 1. Apply TTY palette (/etc/vtrgb + live kernel VT parameters + setvtrgb)
if [[ -d /sys/module/vt/parameters ]]; then
  install -m 644 "$TTY_VTRGB_FILE" "$VTRGB_TARGET"
  printf '%s\n' "$EXPECTED_RED" >/sys/module/vt/parameters/default_red
  printf '%s\n' "$EXPECTED_GRN" >/sys/module/vt/parameters/default_grn
  printf '%s\n' "$EXPECTED_BLU" >/sys/module/vt/parameters/default_blu
  if command -v setvtrgb >/dev/null 2>&1 && [[ -e /dev/tty0 ]]; then
    setvtrgb "$VTRGB_TARGET" 2>/dev/null || true
  fi
  echo "==> Applied Catppuccin Macchiato palette to Linux TTY."
fi

# 2. Apply Limine bootloader theme & persistent TTY kernel cmdline
if [[ -f /etc/default/limine || -f /etc/limine-entry-tool.conf ]]; then
  install -d -m 755 "$DROPIN_DIR"
  cat >"$DROPIN_FILE" <<EOF
# Managed by mise dotfiles (theme-catppuccin)
KERNEL_CMDLINE[default]+="${TTY_CMDLINE}"
EOF
  chmod 644 "$DROPIN_FILE"

  if [[ -d "$HOOK_DIR" ]]; then
    cat >"$HOOK_FILE" <<EOF
#!/usr/bin/env bash
exec "${SCRIPT_DIR}/apply-catppuccin-boot-tty.sh" --limine-hook
EOF
    chmod 755 "$HOOK_FILE"
  fi

  limine_conf="$(resolve_limine_conf)"
  patch_limine_conf "$limine_conf"

  install -d -m 755 "$STAMP_DIR"
  printf '%s\n' "$EXPECTED_STAMP" >"$STAMP_FILE"
  chmod 644 "$STAMP_FILE"
fi
