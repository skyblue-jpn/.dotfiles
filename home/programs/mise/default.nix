{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.mise = {
    enable = true;
    package = inputs.mise-flake.packages.${pkgs.system}.mise;
  };

  xdg.configFile = {
    "mise/config.toml".source = ./config.toml;
  };
}
