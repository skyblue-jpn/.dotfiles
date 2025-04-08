{
  description = "Description for the project";

  inputs = {
    # core
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    chaotic = {
      url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    # flake-parts module
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    # development
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fix-python = {
      url = "github:GuillaumeDesforges/fix-python";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    # desktop
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    # themes
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    # other packages
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    mise-flake = {
      url = "github:jdx/mise";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      chaotic,
      home-manager,
      systems,
      treefmt-nix,
      nix-ld,
      fix-python,
      catppuccin,
      yazi,
      mise-flake,
      nix-flatpak,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = import systems;
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          packages.default = pkgs.hello;
          treefmt.programs = {
            nixfmt.enable = true;
            prettier.enable = true;
            prettier.settings.embeddedLanguageFormatting = "auto";
          };
        };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
        nixosConfigurations = {
          myNixOS = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./nixos/configuration.nix
              chaotic.nixosModules.default
              home-manager.nixosModules.home-manager
              catppuccin.nixosModules.catppuccin
              nix-ld.nixosModules.nix-ld
              nix-flatpak.nixosModules.nix-flatpak
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.celeste = {
                    imports = [
                      ./home/home.nix
                      catppuccin.homeModules.catppuccin
                      nix-flatpak.homeManagerModules.nix-flatpak
                    ];
                  };
                };
              }
            ];
          };
        };
      };
    };
}
