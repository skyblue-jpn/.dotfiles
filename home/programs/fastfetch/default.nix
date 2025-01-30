{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
  };

  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./config.jsonc;
  };
}
