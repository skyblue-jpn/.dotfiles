#!/bin/bash
set -euo pipefail

FORCE=0
if [[ "${1:-}" == "--force" ]]; then
  FORCE=1
fi

readonly CHAOTIC_MIRRORLIST="/etc/pacman.d/chaotic-mirrorlist"

# Remove stale pacnew file if present
if [[ -f "${CHAOTIC_MIRRORLIST}.pacnew" ]]; then
  sudo rm -f "${CHAOTIC_MIRRORLIST}.pacnew"
fi

# Skip full mirror benchmarking during routine bootstrap runs if mirrors were
# already updated within the last 24 hours.
if [[ "$FORCE" -eq 0 && -f "$CHAOTIC_MIRRORLIST" ]] &&
  grep -q '^Server = ' "$CHAOTIC_MIRRORLIST" &&
  [[ -n "$(find "$CHAOTIC_MIRRORLIST" -mmin -1440 2>/dev/null)" ]]; then
  echo "==> Mirrors were already updated within the last 24 hours; skipping."
  exit 0
fi

echo "==> Updating CachyOS and Arch mirrorlists..."
sudo cachyos-rate-mirrors

echo "==> Updating Chaotic-AUR mirrorlist..."
tmp_mirrorlist="$(mktemp)"
trap 'rm -f "$tmp_mirrorlist"' EXIT

if rate-mirrors chaotic-aur >"$tmp_mirrorlist" && grep -q '^Server = ' "$tmp_mirrorlist"; then
  sudo install -m 644 "$tmp_mirrorlist" "$CHAOTIC_MIRRORLIST"
  echo "==> Chaotic-AUR mirrorlist updated successfully."
else
  echo "Warning: rate-mirrors failed to produce a valid chaotic-mirrorlist; keeping existing file." >&2
fi
