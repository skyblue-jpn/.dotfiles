#!/bin/sh

# Stop the script if an error occurs, if an undefined variable is used, or if a command in a pipeline fails
set -euxo pipefail

# Move to the directory where the script exists
cd "$(dirname "$0")"

# Update the flake
nix flake update

# Rebuild and switch to the new NixOS configuration, installing the bootloader
sudo nixos-rebuild switch --flake .#myNixOS --install-bootloader

# Switch to the new Home Manager configuration
nix run nixpkgs#home-manager -- switch --flake .#myHome

# Perform garbage collection on the Nix store
sudo nix store gc
