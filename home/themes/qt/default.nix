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

  xdg.configFile = {
    "Kvantum/ArcDark".source = "${pkgs.catppuccin-kvantum}/share/themes/catppuccin-macchiato-mauve";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=catppuccin-macchiato-mauve";
  };

}
