{ pkgs, ... }:

{
  home.pointerCursor = {
    name = "catppuccin-macchiato-dark-cursors";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };
}
