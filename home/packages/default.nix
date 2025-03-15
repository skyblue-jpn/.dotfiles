{ pkgs, ... }:

{
  home.packages = with pkgs; [
    audacious
    baobab
    bitwarden
    bottles
    bulky
    cbonsai
    celluloid
    efibootmgr
    ffmpeg
    gimp
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
    pwvucontrol_git
    qalculate-gtk
    rclone
    sl
    stix-two
    ventoy-full
    warpinator
    xviewer
    zoom-us
    xfce.catfish
  ];
}
