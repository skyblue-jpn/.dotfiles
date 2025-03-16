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
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = inputs: {
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

    nixosConfigurations = {
      myNixOS = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          inputs.chaotic.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
        ];
      };
    };

    homeConfigurations = {
      myHome = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
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
