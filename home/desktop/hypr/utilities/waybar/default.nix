{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config".source = ./config;
  };
  home.packages = [
    nerd-fonts-fantasque-sans-mono
  ];
}
