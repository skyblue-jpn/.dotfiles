{ config, pkgs, ... }:

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
    gnome-screenshot
  ];
  #  environment.systemPackages = with pkgs; [
  #    nixos-artwork.wallpapers.nineish-catppuccin-macchiato-alt
  #  ];
}
