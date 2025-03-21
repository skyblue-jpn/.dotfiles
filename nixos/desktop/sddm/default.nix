{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = hyprland;
}
