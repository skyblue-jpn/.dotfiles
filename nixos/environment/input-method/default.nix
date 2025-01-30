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
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            EnumerateForwardKeys = "";
            EnumerateBackwardKeys = "";
            EnumerateSkipFirst = false;
            TriggerKeys = {
              "0" = "Control+space";
              "1" = "Zenkaku_Hankaku";
              "2" = "Hangul";
            };
            AltTriggerKeys = {
              "0" = "Shift_L";
            };
            EnumerateGroupForwardKeys = {
              "0" = "Super+space";
            };
            EnumerateGroupBackwardKeys = {
              "0" = "Shift+Super+space";
            };
            ActivateKeys = {
              "0" = "Hangul_Hanja";
            };
            DeactivateKeys = {
              "0" = "Hangul_Romaja";
            };
            PrevPage = {
              "0" = "Up";
            };
          };
        };
      };
      waylandFrontend = true;
    };
  };
}
