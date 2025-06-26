{
  description = "Description for the project";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nuschtosSearch = {
      url = "github:NuschtOS/search";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic = {
      url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fix-python = {
      url = "github:GuillaumeDesforges/fix-python";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nuschtosSearch.follows = "nuschtosSearch";
    };
    quadlet-nix = {
      url = "github:SEIAROTg/quadlet-nix";
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
      nix-index-database,
      catppuccin,
      yazi,
      mise-flake,
      nixvim,
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
            nixfmt = {
              enable = true;
              excludes = [ ];
              includes = [ "*.nix" ];
            };
            biome = {
              enable = true;
              excludes = [ ];
              includes = [
                "*.js"
                "*.json"
                "*.jsonc"
              ];
            };
            prettier = {
              enable = true;
              excludes = [ ];
              includes = [
                "*.css"
                "*.html"
                "*.md"
                "*.mdx"
              ];
            };
            taplo = {
              enable = true;
              excludes = [ ];
              includes = [ "*.toml" ];
            };
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
              nixvim.nixosModules.nixvim
              quadlet-nix.nixosModules.quadlet
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  backupFileExtension = "backup";
                  users.celeste = {
                    imports = [
                      ./home/home.nix
                      nix-index-database.hmModules.nix-index
                      catppuccin.homeModules.catppuccin
                      nixvim.homeManagerModules.nixvim
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
