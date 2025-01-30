{ lib, pkgs, ... }:

{
  home.pointerCursor = {
    name = lib.mkForce "catppuccin-macchiato-dark-cursors";
    size = 19;
    gtk.enable = true;
    x11.enable = true;
  };
}
