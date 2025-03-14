{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
  };
  services.hypridle = {
    enable = true;
  };
  programs.waybar = {
    enable = true;
  };
  programs.wofi = {
    enable = true;
  };
}
