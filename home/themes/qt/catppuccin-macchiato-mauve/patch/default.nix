{ pkgs, ... }:

{
  xdg.configFile = {
    "Kvantum/catppuccin-macchiato-mauve/catppuccin-macchiato-mauve.kvconfig".source =
      ./kvantum.kvconfig;
    "Kvantum/catppuccin-macchiato-mauve/catppuccin-macchiato-mauve.svg".source = ./kvantum.svg;
  };
}
