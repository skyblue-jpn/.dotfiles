{ config, pkgs, ... }:

{
  imports = [
    ./waybar
    ./tofi
  ];

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
  programs.tofi = {
    enable = true;
  };
  home.packages = with pkgs; [
    swww
  ];
}
