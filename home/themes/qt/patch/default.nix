{ pkgs, ... }:

{
  xdg.configFile = {
    "Kvantum/catppuccin-macchiato-mauve/catppuccin-macchiato-mauve.kvconfig".source =
      ./catppuccin-macchiato-mauve.kvconfig;
    "Kvantum/catppuccin-macchiato-mauve/catppuccin-macchiato-mauve.svg".source =
      ./catppuccin-macchiato-mauve.svg;
  };
}
