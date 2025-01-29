#!/bin/sh

# Stop the script if an error occurs, if an undefined variable is used, or if a command in a pipeline fails
set -euxo pipefail

# Move to the directory where the script exists
cd "$(dirname "$0")"

# Function to update the flake
update_flake() {
    nix flake update
}

# Function to rebuild and switch to the new NixOS configuration, installing the bootloader
rebuild_nixos() {
    sudo nixos-rebuild switch --flake .#myNixOS --install-bootloader
}

# Function to switch to the new Home Manager configuration
switch_home_manager() {
    nix run nixpkgs#home-manager -- switch --flake .#myHome
}

# Function to perform garbage collection on the Nix store
garbage_collect() {
    sudo nix store gc
}

# Check the provided argument and call the corresponding function
case "$1" in
u | update)
    update_flake
    ;;
r | rebuild)
    rebuild_nixos
    ;;
s | switch)
    switch_home_manager
    ;;
g | gc)
    garbage_collect
    ;;
*)
    # Default behavior if no argument is provided
    update_flake
    rebuild_nixos
    switch_home_manager
    garbage_collect
    ;;
esac
