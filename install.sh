#!/bin/sh

# Stop the script if an error occurs, if an undefined variable is used, or if a command in a pipeline fails
set -euxo pipefail

# Move to the directory where the script exists
cd "$(dirname "$0")"

# Function to update the flake
update_flake() {
    echo "Running: update_flake"
    nix flake update
}

# Function to rebuild and switch to the new NixOS configuration, installing the bootloader
rebuild_nixos() {
    echo "Running: rebuild_nixos"
    sudo nixos-rebuild switch --flake .#myNixOS --install-bootloader
}

# Function to switch to the new Home Manager configuration
switch_home_manager() {
    echo "Running: switch_home_manager"
    nix run nixpkgs#home-manager switch --flake .#myHome
}

# Function to perform garbage collection on the Nix store
garbage_collect() {
    echo "Running: garbage_collect"
    sudo nix store gc
}

# Function to delete lock files
delete_lock_files() {
    echo "Running: delete_lock_files"
    find /home/celeste/.dotfiles -name "*.lock" -type f -delete
}

# Default behavior if no argument is provided
default_behavior() {
    update_flake
    rebuild_nixos
    switch_home_manager
    garbage_collect
}

# Check the provided arguments and call the corresponding functions
if [ $# -eq 0 ]; then
    default_behavior
else
    for arg in "$@"; do
        case "$arg" in
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
        d | delete-locks)
            delete_lock_files
            ;;
        *)
            echo "Invalid argument: $arg"
            exit 1
            ;;
        esac
    done
fi
