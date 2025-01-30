{ config, pkgs, ... }:

{
  programs.topgrade = {
    enable = true;
  };

  xdg.configFile = {
    "topgrade.tom".source = ./topgrade.toml;
  };
}
