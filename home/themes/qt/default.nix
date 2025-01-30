{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.qt6ct
    libsForQt5.qt5ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
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
}
