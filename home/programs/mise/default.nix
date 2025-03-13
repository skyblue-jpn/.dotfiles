{
  config,
  pkgs,
  inputs,
  ...
}:

let
  nightlyRust = pkgs.rust-overlay.latest.nightly.default;
in
{
  programs.mise = {
    enable = true;
    package = inputs.mise-flake.packages.${pkgs.system}.mise.overrideAttrs (oldAttrs: rec {
      buildInputs = oldAttrs.buildInputs or [ ] ++ [
        nightlyRust.rustc
        nightlyRust.cargo
      ];
    });
  };

  xdg.configFile = {
    "mise/config.toml".source = ./config.toml;
  };
}
