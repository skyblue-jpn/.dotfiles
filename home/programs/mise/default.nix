{
  config,
  pkgs,
  inputs,
  ...
}:

let
  overlayPkgs = import inputs.nixpkgs {
    system = pkgs.system;
    config.allowUnfree = true;
    overlays = [ (import inputs.rust-overlay) ];
  };
  nightlyRust = overlayPkgs."rust-bin".nightly.latest;
in
{
  programs.mise = {
    enable = true;
    package = inputs.mise-flake.packages.${pkgs.system}.mise.overrideAttrs (oldAttrs: rec {
      buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
        nightlyRust.rustc
      ];
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
        nightlyRust.cargo
      ];
      preBuild = ''
        export CARGO=${nightlyRust.cargo}/bin/cargo
      '';
    });
  };

  xdg.configFile = {
    "mise/config.toml".source = ./config.toml;
  };
}
