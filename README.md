# .dotfiles

My NixOS dotfiles

## references

- Garuda Linux (some system config and hyprland dots)
- Alter Linux (dconf for cinnamon)

## Installation

To install, run the following command:

```sh
chmod +x install.sh
./install.sh
```

## install.sh

The `install.sh` script automates the setup and maintenance of your NixOS configuration. It includes the following functions:

- **update_flake**: Updates the flake.
- **rebuild_nixos**: Rebuilds and switches to the new NixOS configuration, installing the bootloader.
- **garbage_collect**: Performs garbage collection on the Nix store.
- **delete_lock_files**: Deletes lock files.

By default, if no arguments are provided, the script will update the flake, rebuild NixOS, switch Home Manager, and perform garbage collection. You can also run specific functions by providing the corresponding arguments:

- `u` or `update`: Run `update_flake`.
- `r` or `rebuild`: Run `rebuild_nixos`.
- `g` or `gc`: Run `garbage_collect`.
- `d` or `delete-locks`: Run `delete_lock_files`.
