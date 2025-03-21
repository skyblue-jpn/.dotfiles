{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    catppuccin.url = "github:catppuccin/nix";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    yazi.url = "github:sxyazi/yazi";
    mise-flake.url = "github:jdx/mise";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs =
    inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in
      {
        formatter = pkgs.nixfmt-rfc-style;

        legacyPackages = {
          inherit (pkgs) home-manager;

          nixosConfigurations = {
            myNixOS = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                ./nixos/configuration.nix
                inputs.chaotic.nixosModules.default
                inputs.catppuccin.nixosModules.catppuccin
                inputs.nix-ld.nixosModules.nix-ld
              ];
            };
          };

          homeConfigurations = {
            myHome = inputs.home-manager.lib.homeManagerConfiguration {
              pkgs = pkgs;
              extraSpecialArgs = { inherit inputs; };
              modules = [
                ./home/home.nix
                inputs.chaotic.homeManagerModules.default
                inputs.catppuccin.homeManagerModules.catppuccin
              ];
            };
          };
        };
      }
    );
}
