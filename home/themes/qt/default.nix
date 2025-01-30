{ lib, pkgs, ... }:

{
  # Fallback conf.
  imports = [
    ./patch
  ];

  home.packages = with pkgs; [
    kdePackages.qtwayland
    kdePackages.qt6ct
    libsForQt5.qt5ct
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-kvantum
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
      package = pkgs.catppuccin-kvantum.override {
        accent = "mauve";
        variant = "macchiato";
      };
    };
  };

  xdg.configFile = {
    "qt5ct/qt5ct.conf".source = ./qt5ct.conf;
    "qt6ct/qt6ct.conf".source = ./qt6ct.conf;
    "Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
  };
}
