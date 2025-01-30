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
    "Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
  };

  home.file.".config/Kvantum/catppuccin-macchiato-mauve".source =
    "${pkgs.catppuccin-kvantum}/themes/catppuccin-macchiato-mauve";
}
