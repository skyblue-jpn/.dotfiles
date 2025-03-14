{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
  };
  services.hypridle = {
    enable = true;
  };
  services.cliphist = {
    enable = true;
  };
  programs.waybar = {
    enable = true;
  };
  programs.wofi = {
    enable = true;
  };
  home.packages = with pkgs; [
    swww
  ];
}
