{ config, pkgs, ... }:

{
  programs.topgrade = {
    enable = true;
  };

  home.file.".config/topgrade.toml" = {
    source = ./topgrade.toml;
  };
}
