{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
  };

  home = {
    file."starship.toml" = {
      enable = true;
      source = ./starship.toml;
      target = ".config/starship.tom";
    };
  };
}
