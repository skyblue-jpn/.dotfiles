{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config".source = ./config;
    "waybar/style.css".source = ./style.css;
    "waybar/themes/macchiato.css".source = ./themes/macchiato.css;
  };
  home.packages = with pkgs; [
    # nerd-fonts.fantasque-sans-mono
    # nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
  ];
}
