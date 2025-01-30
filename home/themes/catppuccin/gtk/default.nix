{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    sassc
    gtk-engine-murrine
    gnome-themes-extra
    magnetic-catppuccin-gtk
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Magnetic-Catppuccin-Macchiato-Compact-Purple-Dark";
      package = pkgs.magnetic-catppuccin-gtk.override {
        accent = [ "purple" ];
        shade = "dark";
        size = "compact";
        tweaks = [
          "macchiato"
          "black"
          "outline"
        ];
      };
    };
    iconTheme = {
      name = "colloid-icon-theme";
      package = pkgs.colloid-icon-theme;
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
