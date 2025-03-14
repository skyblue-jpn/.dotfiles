{ config, pkgs, ... }:

{
  programs = {
    # shell
    fish = {
      enable = true;
    };
    xonsh = {
      enable = true;
    };
    # tools
    dconf = {
      enable = true;
    };
    gnome-disks = {
      enable = true;
    };
    file-roller = {
      enable = true;
    };
    noisetorch = {
      enable = true;
    };
  };
}
