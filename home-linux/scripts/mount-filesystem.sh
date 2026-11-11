#!/bin/bash
# Mount an NTFS partition safely and idempotently on Arch Linux.

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: mount-filesystem.sh [options]

Options:
  --mode <game|storage>    Mount profile (default: game)
  --partition <path>       Target block device (required unless PARTITION is set)
  --mount-point <path>     Mount point directory
  --uid <uid>              UID for mount ownership (default: invoking user)
  --gid <gid>              GID for mount ownership (default: invoking user)
  --filesystem <type>      Filesystem driver (default: ntfs-3g)
  --fstab-options <opts>   fstab mount options
                           (mode default: game=umask=000, storage=umask=022)
  --interactive             Configure and mount multiple partitions
  --dry-run                Print planned actions without changing the system
  --help                   Show this help

Environment overrides:
  MOUNT_MODE, MOUNT_PARTITION, PARTITION, MOUNT_POINT, MOUNT_UID, MOUNT_GID,
  FILESYSTEM, FSTAB_OPTIONS
USAGE
}

error() {
  echo "Error: $*" >&2
}

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    error "Required command not found: $cmd"
    exit 1
  fi
}

is_number() {
  [[ "$1" =~ ^[0-9]+$ ]]
}

MODE="${MOUNT_MODE:-game}"
PARTITION="${PARTITION:-${MOUNT_PARTITION:-}}"
MOUNT_POINT="${MOUNT_POINT:-}"
FILESYSTEM="${FILESYSTEM:-ntfs-3g}"
TARGET_UID="${MOUNT_UID:-${SUDO_UID:-$(id -u)}}"
TARGET_GID="${MOUNT_GID:-${SUDO_GID:-$(id -g)}}"
FSTAB_OPTIONS="${FSTAB_OPTIONS:-}"
INTERACTIVE=0
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)
      [[ $# -ge 2 ]] || {
        error "--mode requires a value"
        exit 1
      }
      MODE="$2"
      shift 2
      ;;
    --partition)
      [[ $# -ge 2 ]] || {
        error "--partition requires a value"
        exit 1
      }
      PARTITION="$2"
      shift 2
      ;;
    --mount-point)
      [[ $# -ge 2 ]] || {
        error "--mount-point requires a value"
        exit 1
      }
      MOUNT_POINT="$2"
      shift 2
      ;;
    --uid)
      [[ $# -ge 2 ]] || {
        error "--uid requires a value"
        exit 1
      }
      TARGET_UID="$2"
      shift 2
      ;;
    --gid)
      [[ $# -ge 2 ]] || {
        error "--gid requires a value"
        exit 1
      }
      TARGET_GID="$2"
      shift 2
      ;;
    --filesystem)
      [[ $# -ge 2 ]] || {
        error "--filesystem requires a value"
        exit 1
      }
      FILESYSTEM="$2"
      shift 2
      ;;
    --fstab-options)
      [[ $# -ge 2 ]] || {
        error "--fstab-options requires a value"
        exit 1
      }
      FSTAB_OPTIONS="$2"
      shift 2
      ;;
    --interactive)
      INTERACTIVE=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      error "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

case "$MODE" in
  game)
    DEFAULT_MOUNT_POINT="/media/gamedisk"
    DEFAULT_UMASK=000
    ;;
  storage)
    DEFAULT_MOUNT_POINT="/media/storage"
    DEFAULT_UMASK=022
    ;;
  *)
    error "Invalid mode: $MODE (expected game or storage)"
    exit 1
    ;;
esac

if [[ -z "$MOUNT_POINT" ]]; then
  MOUNT_POINT="$DEFAULT_MOUNT_POINT"
fi
if [[ -z "$FSTAB_OPTIONS" ]]; then
  FSTAB_OPTIONS="uid=${TARGET_UID},gid=${TARGET_GID},rw,user,exec,umask=${DEFAULT_UMASK}"
fi

if [[ $INTERACTIVE -eq 1 ]]; then
  if [[ -n "$PARTITION" ]]; then
    error "--interactive cannot be combined with --partition or MOUNT_PARTITION"
    exit 1
  fi
  if [[ ! -t 0 || ! -t 1 ]]; then
    error "interactive setup requires a terminal"
    exit 1
  fi
  require_cmd lsblk
  printf 'Available filesystems:\n'
  lsblk --fs
  printf '\nDisable Windows Fast Startup and hibernation before mounting\n'
  printf 'a shared NTFS volume read-write.\n\n'
  while true; do
    read -r -p 'Partition path (empty to finish): ' PARTITION
    [[ -z "$PARTITION" ]] && break
    read -r -p "Mount point [${MOUNT_POINT}]: " INTERACTIVE_MOUNT_POINT
    if [[ -n "$INTERACTIVE_MOUNT_POINT" ]]; then
      MOUNT_POINT="$INTERACTIVE_MOUNT_POINT"
    fi
    "$0" --mode "$MODE" --partition "$PARTITION" \
      --mount-point "$MOUNT_POINT" \
      --uid "$TARGET_UID" \
      --gid "$TARGET_GID" \
      --filesystem "$FILESYSTEM" \
      --fstab-options "$FSTAB_OPTIONS"
    PARTITION=""
    MOUNT_POINT="$DEFAULT_MOUNT_POINT"
    printf '\n'
  done
  exit 0
fi

[[ -n "$PARTITION" ]] || {
  error "partition must not be empty"
  exit 1
}
[[ -n "$MOUNT_POINT" ]] || {
  error "mount point must not be empty"
  exit 1
}
[[ "$MOUNT_POINT" == /* && "$MOUNT_POINT" != "/" ]] || {
  error "mount point must be an absolute path other than /"
  exit 1
}
[[ "$MOUNT_POINT" != *[[:space:]]* ]] || {
  error "mount point must not contain whitespace"
  exit 1
}
[[ -n "$FILESYSTEM" ]] || {
  error "filesystem must not be empty"
  exit 1
}
[[ "$FILESYSTEM" != *[[:space:]]* ]] || {
  error "filesystem must not contain whitespace"
  exit 1
}

if ! is_number "$TARGET_UID"; then
  error "Invalid uid: $TARGET_UID"
  exit 1
fi
if ! is_number "$TARGET_GID"; then
  error "Invalid gid: $TARGET_GID"
  exit 1
fi

if [[ "$EUID" -ne 0 ]]; then
  require_cmd sudo
  sudo_args=(
    --mode "$MODE"
    --partition "$PARTITION"
    --mount-point "$MOUNT_POINT"
    --uid "$TARGET_UID"
    --gid "$TARGET_GID"
    --filesystem "$FILESYSTEM"
    --fstab-options "$FSTAB_OPTIONS"
  )
  if [[ $DRY_RUN -eq 1 ]]; then
    sudo_args+=(--dry-run)
  fi
  exec sudo "$0" "${sudo_args[@]}"
fi

for cmd in pacman blkid findmnt mount mountpoint grep awk mkdir cp date tee; do
  require_cmd "$cmd"
done

if [[ ! -b "$PARTITION" ]]; then
  error "Device does not exist or is not a block device: $PARTITION"
  exit 1
fi

if ! pacman -Q ntfs-3g >/dev/null 2>&1; then
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry-run] pacman -Syu --noconfirm ntfs-3g"
  else
    echo "Installing ntfs-3g..."
    if ! pacman -Syu --noconfirm ntfs-3g; then
      error "Failed to install ntfs-3g"
      exit 1
    fi
  fi
fi

if [[ ! -d "$MOUNT_POINT" ]]; then
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry-run] mkdir -p $MOUNT_POINT"
  else
    if ! mkdir -p "$MOUNT_POINT"; then
      error "Failed to create mount point: $MOUNT_POINT"
      exit 1
    fi
  fi
fi

if ! UUID="$(blkid -s UUID -o value -- "$PARTITION" 2>/dev/null)"; then
  error "Failed to get UUID for device: $PARTITION"
  exit 1
fi
if [[ -z "$UUID" ]]; then
  error "UUID is empty for device: $PARTITION"
  exit 1
fi

if mountpoint -q "$MOUNT_POINT"; then
  MOUNTED_SOURCE="$(awk -v mp="$MOUNT_POINT" '$2==mp {print $1; exit}' /proc/mounts)"
  if [[ "$MOUNTED_SOURCE" == "UUID=$UUID" || "$MOUNTED_SOURCE" == "$PARTITION" ]]; then
    echo "Mount point is already correctly mounted: $MOUNT_POINT"
    exit 0
  fi

  if [[ -b "$MOUNTED_SOURCE" ]]; then
    if MOUNTED_UUID="$(blkid -s UUID -o value -- "$MOUNTED_SOURCE" 2>/dev/null)"; then
      if [[ "$MOUNTED_UUID" == "$UUID" ]]; then
        echo "Mount point is already correctly mounted: $MOUNT_POINT"
        exit 0
      fi
    fi
  fi

  error "Mount point already mounted by a different filesystem/source: $MOUNTED_SOURCE"
  exit 1
fi

MOUNTED_OTHER_POINT="$(
  findmnt -rn -S "UUID=$UUID" -o TARGET 2>/dev/null |
    awk 'NR==1 {print; exit}' ||
    true
)"
if [[ -n "$MOUNTED_OTHER_POINT" && "$MOUNTED_OTHER_POINT" != "$MOUNT_POINT" ]]; then
  error "Partition UUID=$UUID is already mounted at $MOUNTED_OTHER_POINT"
  error "Unmount it there before assigning a different mount point"
  exit 1
fi

FSTAB_LINE="UUID=$UUID $MOUNT_POINT $FILESYSTEM $FSTAB_OPTIONS 0 0"
FILTERED_FSTAB="$(grep -Ev '^[[:space:]]*#|^[[:space:]]*$' /etc/fstab || true)"

CONFLICT_UUID_ENTRY="$(printf '%s\n' "$FILTERED_FSTAB" | awk -v u="UUID=$UUID" -v m="$MOUNT_POINT" '$1==u && $2!=m {print; exit}')"
if [[ -n "$CONFLICT_UUID_ENTRY" ]]; then
  error "UUID $UUID is already registered in /etc/fstab with a different mount point: $CONFLICT_UUID_ENTRY"
  exit 1
fi

EXISTING_ENTRY="$(printf '%s\n' "$FILTERED_FSTAB" | awk -v u="UUID=$UUID" -v m="$MOUNT_POINT" '$1==u && $2==m {print; exit}')"
if [[ -z "$EXISTING_ENTRY" ]]; then
  EXISTING_MOUNT_POINT_ENTRY="$(printf '%s\n' "$FILTERED_FSTAB" | awk -v m="$MOUNT_POINT" '$2==m {print; exit}')"
  if [[ -n "$EXISTING_MOUNT_POINT_ENTRY" ]]; then
    error "Mount point $MOUNT_POINT is already used by another /etc/fstab entry: $EXISTING_MOUNT_POINT_ENTRY"
    exit 1
  fi

  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry-run] cp /etc/fstab /etc/fstab.bak.<timestamp>"
    echo "[dry-run] append to /etc/fstab: $FSTAB_LINE"
  else
    BACKUP_PATH="/etc/fstab.bak.$(date +%Y%m%d%H%M%S)"
    if ! cp /etc/fstab "$BACKUP_PATH"; then
      error "Failed to backup /etc/fstab to $BACKUP_PATH"
      exit 1
    fi

    if ! printf '%s\n' "$FSTAB_LINE" | tee -a /etc/fstab >/dev/null; then
      error "Failed to update /etc/fstab"
      exit 1
    fi
  fi
else
  echo "Reusing existing /etc/fstab entry for UUID=$UUID at $MOUNT_POINT"
fi

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[dry-run] mount $MOUNT_POINT"
else
  if ! mount "$MOUNT_POINT"; then
    error "Failed to mount $MOUNT_POINT"
    exit 1
  fi
fi

echo "Completed successfully."
