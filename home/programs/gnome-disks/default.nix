{ config, pkgs, ... }:

{
  programs.gnome-disks = {
    enable = true;
  };
}
