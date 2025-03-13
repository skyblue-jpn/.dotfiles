{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.mise = {
    enable = true;
    #    package = inputs.mise-flake.packages.${pkgs.system}.mise;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableFishIntegration = true;
  };

  xdg.configFile = {
    "mise/config.toml".source = ./config.toml;
  };
}
