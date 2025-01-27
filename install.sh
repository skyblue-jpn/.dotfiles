#!/bin/sh

# Stop the script if an error occurs, if an undefined variable is used, or if a command in a pipeline fails
set -euxo pipefail

# Move to the directory where the script exists
cd "$(dirname "$0")"

# Update the flake
nix flake update
echo "Flake update completed."

# Rebuild and switch to the new NixOS configuration, installing the bootloader
sudo nixos-rebuild switch --flake .#myNixOS --install-bootloader
echo "NixOS rebuild completed."

# Switch to the new Home Manager configuration
nix run nixpkgs#home-manager -- switch --flake .#myHome
echo "Home Manager switch completed."

# Perform garbage collection on the Nix store
sudo nix store gc
echo "Nix store garbage collection completed."
