#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

echo "==> Starting Chaotic-AUR installation script..."

# 1. Receive and locally sign the Chaotic-AUR master key
echo "==> 1. Importing Chaotic-AUR signing key..."
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

# 2. Install chaotic-keyring and chaotic-mirrorlist packages
echo "==> 2. Installing chaotic-keyring and chaotic-mirrorlist..."
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# 3. Append repository configuration to /etc/pacman.conf (with duplicate check)
echo "==> 3. Adding repository configuration to /etc/pacman.conf..."

if grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
  echo "==> chaotic-aur is already configured in /etc/pacman.conf."
else
  echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
  echo "==> Successfully updated /etc/pacman.conf."
fi

# 4. Synchronize package databases
echo "==> 4. Synchronizing package databases..."
sudo pacman -Syyu --noconfirm

echo "==> All done! Chaotic-AUR has been successfully added."
