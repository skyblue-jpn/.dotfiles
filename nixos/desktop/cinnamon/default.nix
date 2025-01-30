{ config, pkgs, ... }:

{
  services.xserver.desktopManager.cinnamon.enable = true;
  environment.cinnamon.excludePackages = [
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
    xviewer
    xreader
    xed-editor
    pix
    celluloid
    gnome-calculator
    gnome-calendar
  ];
}
