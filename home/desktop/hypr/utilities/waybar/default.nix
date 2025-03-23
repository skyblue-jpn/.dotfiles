{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config.jsonc".source = ./config.jsonc;
    "waybar/style.css".source = ./style.css;
    "waybar/themes/macchiato.css".source = ./themes/macchiato.css;
  };
  home.packages = with pkgs; [

  ];
}
