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
      name = "Catppuccin-GTK-Purple-Dark-Compact-Macchiato";
      package = pkgs.magnetic-catppuccin-gtk.override {
        accent = [ "purple" ];
        shade = "dark";
        size = "compact";
        tweaks = [
          "macchiato"
          "black"
          "outline"
          "macos"
        ];
      };
    };
    iconTheme = {
      name = "Colloid-Purple-Catppuccin-Dark";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = [ "catppuccin" ];
        colorVariants = [ "purple" ];
      };
    };
  };

  xdg.configFile = {
    "gtk-4.0/assets".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source =
      "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
