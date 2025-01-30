{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab
    bitwarden
    bottles
    bulky
    cbonsai
    efibootmgr
    ffmpeg
    gimp
    gnome-screenshot
    gparted
    heroic
    imagemagick
    inkscape
    libreoffice-fresh
    nemo-with-extensions
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
    warpinator
    zoom-us
  ];
}
