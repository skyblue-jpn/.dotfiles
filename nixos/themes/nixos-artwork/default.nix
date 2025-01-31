{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.nixos-artwork; [
    wallpapers.catppuccin-macchiato
    #icons
  ];
}
