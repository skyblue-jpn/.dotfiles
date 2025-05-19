{ pkgs, ... }:

{
  imports = [
    ./gaming
    ./online-accounts
    ./sound
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
    evolution = {
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
      libraries = with pkgs; [
        SDL2
        curl
        freetype
        gdk-pixbuf
        glib
        glibc
        icu
        libglvnd
        libnotify
        libsecret
        libunwind
        libuuid
        openssl
        stdenv.cc.cc
        util-linux
        vulkan-loader
        xorg.libX11
        zlib
      ];
    };
    uwsm = {
      enable = true;
    };
  };
}
