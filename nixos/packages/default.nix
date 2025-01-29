{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
  ];
}
