{ config, pkgs, ... }:

{
  home.packages = with pkgs.nixos-artwork; [
    wallpapers.catppuccin-macchiato
  ];
}
