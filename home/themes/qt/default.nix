{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.qtwayland
    kdePackages.qt6ct
    libsForQt5.qt5ct
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-kvantum
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  qt = {
    enable = true;
    style = {
      name = "kvantum";
      package = pkgs.catppuccin-kvantum.override {
        accent = "mauve";
        variant = "macchiato";
      };
    };
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
  };
}
