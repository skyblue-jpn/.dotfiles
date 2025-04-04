{ config, pkgs, ... }:

# Additional settings are managed by home-manager.

{
  services.xserver.desktopManager.cinnamon.enable = true;
  environment.cinnamon.excludePackages = with pkgs; [
    adwaita-icon-theme
    sound-theme-freedesktop
    nixos-artwork.wallpapers.simple-dark-gray
    mint-artwork
    mint-cursor-themes
    mint-l-icons
    mint-l-theme
    mint-themes
    mint-x-icons
    mint-y-icons
    ubuntu-classic
    xreader
    xed-editor
    gnome-calculator
    gnome-calendar
  ];
}
