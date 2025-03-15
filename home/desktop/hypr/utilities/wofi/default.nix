{ config, pkgs, ... }:

{
  xdg.configFile = {
    "wofi/config".source = ./config;
    "wofi/style.css".source = ./themes/macchiato/style.css;
  };
}
