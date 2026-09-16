#!/bin/bash
# Mount NTFS partition and update /etc/fstab if necessary.

set -euo pipefail

# ==========================================
# Configuration (Modify these if needed)
# ==========================================
readonly PARTITION="/dev/nvme0n1p5"
readonly MOUNT_POINT="/media/gamedisk"
readonly FSTAB_OPTS="lowntfs-3g uid=1000,gid=1000,rw,user,exec,umask=000 0 0"

echo "==> Starting NTFS partition mount script..."

# Ensure root privileges
if [ "$EUID" -ne 0 ]; then
  echo "==> Root privileges required. Re-running with sudo..."
  exec sudo "$0" "$@"
fi

# 1. Install ntfs-3g if missing
if ! pacman -Q ntfs-3g &>/dev/null; then
  echo "==> Installing ntfs-3g..."
  pacman -Syu --noconfirm ntfs-3g || {
    echo "==> Failed to install ntfs-3g. Exiting, mise will continue."
    exit 0
  }
else
  echo "==> ntfs-3g is already installed."
fi

# 2. Create mount point
if [ ! -d "$MOUNT_POINT" ]; then
  echo "==> Creating mount point at $MOUNT_POINT..."
  mkdir -p "$MOUNT_POINT"
fi

# 3. Get partition UUID
UUID=$(blkid -s UUID -o value "$PARTITION")
if [ -z "$UUID" ]; then
  echo "==> Could not find UUID for $PARTITION. Exiting, mise will continue."
  exit 0
fi

# 4. Update /etc/fstab if not present
if ! grep -q "$UUID" /etc/fstab; then
  echo "==> Backing up /etc/fstab to /etc/fstab.bak..."
  cp /etc/fstab /etc/fstab.bak

  echo "==> Adding $PARTITION to /etc/fstab..."
  echo "UUID=$UUID $MOUNT_POINT $FSTAB_OPTS" >>/etc/fstab
else
  echo "==> Entry for $PARTITION already exists in /etc/fstab."
fi

# 5. Mount partition
echo "==> Mounting $PARTITION at $MOUNT_POINT..."
mount "$MOUNT_POINT" || {
  echo "==> Failed to mount $PARTITION. Exiting, mise will continue."
  exit 0
}

echo "==> All done! NTFS partition has been successfully configured."
