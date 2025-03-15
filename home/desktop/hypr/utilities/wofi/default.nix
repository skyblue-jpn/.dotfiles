{ config, pkgs, ... }:

{
  xdg.configFile = {
    "wofi/config".source = ./config;
  };
}
