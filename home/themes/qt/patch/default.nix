{ pkgs, ... }:

# This is a patch to fix the broken Kvantum theming on qt5.
# The theming file was already downloaded from the repository so it could not update automatically.

{
  xdg.configFile = {
    "Kvantum/catppuccin-macchiato-mauve/catppuccin-macchiato-mauve.kvconfig".source =
      ./catppuccin-macchiato-mauve.kvconfig;
    "Kvantum/catppuccin-macchiato-mauve/catppuccin-macchiato-mauve.svg".source =
      ./catppuccin-macchiato-mauve.svg;
  };
}
