{ config, pkgs, ... }:

# The configuration file of fcitx5 is managed by home-manager

{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc-ut
        fcitx5-gtk
        fcitx5-lua
        kdePackages.fcitx5-qt
      ];
      waylandFrontend = true;
    };
  };
}
