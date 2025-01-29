{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab
    bitwarden
    bottles
    cbonsai
    efibootmgr
    ffmpeg
    gimp
    gparted
    heroic
    imagemagick
    inkscape
    libreoffice-fresh
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
