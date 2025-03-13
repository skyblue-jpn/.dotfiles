{
  config,
  pkgs,
  inputs,
  ...
}:

let
  nightlyRust = inputs.rust-overlay.packages.${pkgs.system}."rust-bin".nightly.latest.default;
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
