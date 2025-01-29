{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    gtk-engine-murrine
    sassc
    gnome-themes-extra
  ];
}
