{ config, pkgs, ... }:

# Fcitx5 is enabled by NixOS global conf

{
  home.file.".config/fcitx5/profile" = {
    source = ./profile;
  };
  home.file.".config/fcitx5/config" = {
    source = ./config;
  };
}
