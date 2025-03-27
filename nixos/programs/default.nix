{ pkgs, ... }:

{
  imports = [
    ./gaming
    ./pipewire
    ./steam
  ];
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
    kdeconnect = {
      enable = true;
    };
    noisetorch = {
      enable = true;
    };
    nix-ld.dev = {
      enable = true;
    };
  };
}
