{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.kdePackages.qtstyleplugin-kvantum
  ];
}
