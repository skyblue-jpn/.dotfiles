{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ dconf-editor ];

  dconf = {
    enable = true;

    settings = {
      "org/cinnamon" = {
        favorite-apps = [
          "nemo.desktop"
          "com.mitchellh.ghostty.desktop"
          "floorp.desktop"
          "cinnamon-settings.desktop"
        ];
        desktop-effects-close-effect = "move";
        desktop-effects-close-time = 100;
        desktop-effects-close-transition = "easeInBack";
        desktop-effects-map-effect = "move";
        desktop-effects-map-time = 100;
        desktop-effects-map-transition = "easeOutSine";
        desktop-effects-maximize-effect = "scale";
        desktop-effects-maximize-time = 100;
        desktop-effects-maximize-transition = "easeInBack";
        desktop-effects-minimize-effect = "move";
        desktop-effects-minimize-time = 100;
        desktop-effects-minimize-transition = "easeInSine";
        desktop-effects-style = "move";
        desktop-effects-tile-effect = "scale";
        desktop-effects-tile-time = 100;
        desktop-effects-tile-transition = "easeInBack";
        desktop-effects-unmaximize-effect = "scale";
        desktop-effects-unmaximize-time = 100;
        desktop-effects-unmaximize-transition = "easeOutBounce";
        enabled-applets = [
          "panel1:left:0:menu@cinnamon.org:0"
          "panel1:left:1:grouped-window-list@cinnamon.org:2"
          "panel1:right:0:systray@cinnamon.org:3"
          "panel1:right:1:xapp-status@cinnamon.org:4"
          "panel1:right:2:notifications@cinnamon.org:5"
          "panel1:right:3:printers@cinnamon.org:6"
          "panel1:right:4:removable-drives@cinnamon.org:7"
          "panel1:right:5:keyboard@cinnamon.org:8"
          "panel1:right:6:network@cinnamon.org:9"
          "panel1:right:7:sound@cinnamon.org:10"
          "panel1:right:8:power@cinnamon.org:11"
          "panel1:right:9:calendar@cinnamon.org:12"
        ];
        hotcorner-layout = [
          "expo:true:0"
          "scale:false:0"
          ":false:0"
          "desktop:true:0"
        ];
        next-applet-id = 13;
        panel-edit-mode = false;
        panels-height = [ "1:40" ];
      };
      "org/cinnamon/cinnamon-session".quit-time-delay = 60;
      "org/cinnamon/desktop/applications/calculator".exec = "qalculate-gtk";
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "ghostty";
        exec-arg = "--";
      };
      "org/cinnamon/desktop/background".picture-uri =
        "file:///home/celeste/nixos-artwork/wallpapers/nix-wallpaper-nineish-catppuccin-macchiato-alt.svg";
      "org/cinnamon/desktop/screensaver" = {
        allow-keyboard-shortcuts = false;
        layout-group = 0;
        lock-enabled = false;
      };
      "org/cinnamon/desktop/sound".event-sounds = false;
      "org/cinnamon/desktop/interface" = {
        cursor-size = 24;
        cursor-theme = "catppuccin-macchiato-light-cursors";
        gtk-theme = "Catppuccin-GTK-Purple-Dark-Compact-Macchiato";
        icon-theme = "Colloid-Purple-Catppuccin-Dark";
        toolkit-accessibility = false;
      };
      "org/cinnamon/desktop/wm/preferences".theme = "Catppuccin-GTK-Purple-Dark-Compact-Macchiato";
      "org/cinnamon/theme".name = "Catppuccin-GTK-Purple-Dark-Compact-Macchiato";

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "catppuccin-macchiato-light-cursors";
        gtk-theme = "Catppuccin-GTK-Purple-Dark-Compact-Macchiato";
        icon-theme = "Colloid-Purple-Catppuccin-Dark";
      };
      "org/x/apps/portal".color-scheme = "prefer-dark";

      "org/nemo/list-view" = {
        default-column-order = [
          "name"
          "size"
          "type"
          "date_modified"
          "date_created_with_time"
          "date_accessed"
          "date_created"
          "detailed_type"
          "group"
          "where"
          "mime_type"
          "date_modified_with_time"
          "octal_permissions"
          "owner"
          "permissions"
        ];
        default-visible-columns = [
          "name"
          "size"
          "type"
          "date_modified"
          "owner"
        ];
      };
      "org/nemo/plugins" = {
        disabled-actions = [ "send-by-mail.nemo_action" ];
      };
      "org/nemo/preferences" = {
        confirm-move-to-trash = true;
        date-format = "iso";
        last-server-connect-method = 3;
        show-computer-icon-toolbar = true;
        show-full-path-titles = true;
        show-hidden-files = true;
        show-home-icon-toolbar = true;
        show-location-entry = true;
        show-new-folder-icon-toolbar = true;
        show-open-in-terminal-toolbar = true;
        show-reload-icon-toolbar = true;
      };
      "org/nemo/preferences/menu-config" = {
        desktop-menu-customize = true;
        selection-menu-make-link = true;
      };
      "org/nemo/window-state" = {
        bookmarks-expanded = true;
        maximized = false;
        sidebar-bookmark-breakpoint = 0;
        start-with-sidebar = true;
      };
    };
  };
}
