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
        inputMethod = {
          Groups = {
            "0" = {
              Name = "US";
              DefaultLayout = "us";
              DefaultIM = "mozc";
              Items = {
                "0" = {
                  Name = "keyboard-us";
                  Layout = "";
                };
                "1" = {
                  Name = "mozc";
                  Layout = "";
                };
              };
            };
            "1" = {
              Name = "JP";
              DefaultLayout = "jp";
              DefaultIM = "mozc";
              Items = {
                "0" = {
                  Name = "keyboard-jp";
                  Layout = "";
                };
                "1" = {
                  Name = "mozc";
                  Layout = "";
                };
              };
            };
          };
          GroupOrder = {
            "0" = "US";
            "1" = "JP";
          };
        };
      };
      waylandFrontend = true;
    };
  };
}
