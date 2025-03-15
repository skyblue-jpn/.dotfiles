{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config".source = ./config;
    "waybar/style.css".source = ./style.css;
  };
  home.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];
}
