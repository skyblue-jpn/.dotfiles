{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config".source = ./config;
  };
}
