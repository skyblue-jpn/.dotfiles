{ config, pkgs, ... }:

{
  home.packages = pkgs.dconf-editor;

  dconf = {
    enable = true;

    settings = {
      "org/cinnamon".favorite-apps = [
        "nemo.desktop"
        "com.mitchellh.ghostty.desktop"
        "floorp.desktop"
        "cinnamon-settings.desktop"
      ];
      "org/cinnamon/desktop/applications/calculator".exec = "qalculate-gtk";
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "ghostty";
        exec-arg = "--";
      };
      "org/cinnamon/desktop/background".picture-uri =
        "${pkgs.nixos-artwork.wallpapers.catppuccin-macchiato}";
      "org/cinnamon/desktop/interface" = {
        cursor-size = 19;
        cursor-theme = "catppuccin-macchiato-dark-cursors";
        gtk-theme = "Catppuccin-GTK-Purple-Dark-Compact-Macchiato";
        icon-theme = "Colloid-Purple-Catppuccin-Dark";
        toolkit-accessibility = false;
      };
      "org/cinnamon/theme".name = "Catppuccin-GTK-Purple-Dark-Compact-Macchiat";

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "catppuccin-macchiato-dark-cursors";
        gtk-theme = "Catppuccin-GTK-Purple-Dark-Compact-Macchiato";
        icon-theme = "Colloid-Purple-Catppuccin-Dark";
      };
      "org/x/apps/portal".color-scheme = "prefer-dark";

      "org/nemo/preferences" = {
        show-full-path-titles = true;
        show-hidden-files = true;
      };
    };
  };
}
