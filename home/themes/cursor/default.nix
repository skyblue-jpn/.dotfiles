{ lib, pkgs, ... }:

{
  home.pointerCursor = {
    name = lib.mkForce "catppuccin-macchiato-light-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
