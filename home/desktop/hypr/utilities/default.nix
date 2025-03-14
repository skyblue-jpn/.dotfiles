{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
  };
  services.hypridle = {
    enable = true;
  };
  programs.waybar.enable = {
    enable = true;
  };
  programs.wofi.enable = {
    enable = true;
  };
}
