# Mise-Builder: NixOS Flake for Building mise Packages

This Flake is designed to build packages for various languages and tools using [mise](https://mise.jdx.dev/) within a NixOS environment managed by Home Manager.

## Description

By using this Flake, you can easily set up a development environment on NixOS, controlled by Home Manager, that is required by `mise`. Specifically, it provides a development shell containing the dependencies defined in `flake.nix`. Within this shell, you can execute `mise` commands to build necessary packages and set up your environment.

## Prerequisites

-   **Nix Package Manager**: NixOS must be installed.
-   **Flakes Feature Enabled**: The Flakes feature in Nix needs to be enabled. If it's not enabled, edit your `nix.conf` file to include `experimental-features = nix-command flakes` and restart the Nix daemon.
-   **Home Manager**: Home Manager must be installed and configured to manage your user environment.

## Usage

To use this Flake, follow these steps:

1.  **Enter the Development Shell**: Run the following command to enter the development shell. **Since this flake is part of your NixOS configuration managed by Home Manager, you might need to use the `--impure` flag:**

    ```bash
    nix develop --impure
    ```

    If you encounter issues with the above commands, try entering the shell from your NixOS configuration where this flake is included.

2.  **Work within the Development Shell**: Inside the development shell, the packages defined in `flake.nix` are available. You can now use `mise` commands to manage language and tool versions, and to build project-specific environments.

    Example:

    ```bash
    mise install nodejs@20
    mise use nodejs@20
    node -v
    ```

## Integration with `mise`

By using `mise` within this development shell, you can easily switch between different versions of languages and tools on a per-project basis. Create a `mise.toml` file in your project's root directory and specify the required versions. `mise` will then utilize the environment provided by this Flake to ensure those tools are available.
