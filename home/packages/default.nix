{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab
    bitwarden
    bottles
    bulky
    cbonsai
    celluloid
    efibootmgr
    ffmpeg
    gimp
    gscreenshot
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
    pix
    polkit
    poppler
    qalculate-gtk
    rclone
    sl
    stix-two
    ventoy-full
    warpinator
    xviewer
    zoom-us
  ];
}
