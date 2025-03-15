{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config".source = ./config;
    "waybar/style.css".source = ./style.css;
    "waybar/themes/macchiato.css".source = ./themes/macchiato.css;
  };
}
