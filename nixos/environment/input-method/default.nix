{ config, pkgs, ... }:

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
      settings = {
        inputMethod = "./profile";
        globalOptions = "./config";
      };
      waylandFrontend = true;
    };
  };
}
