{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config".source = ./config;
  };
  home.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];
}
