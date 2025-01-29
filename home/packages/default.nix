{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab
    bitwarden
    bottles
    cbonsai
    efibootmgr
    ffmpeg
    ghostty
    gimp
    gparted
    heroic
    imagemagick
    inkscape
    libreoffice-fresh
    nixfmt-rfc-style
    p7zip
    peaclock
    pingu
    pipes-rs
    polkit
    poppler
    rclone
    sl
    stix-two
    ventoy-full
    zoom-us
  ];
}
