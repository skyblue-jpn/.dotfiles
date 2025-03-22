{ pkgs, ... }:

{
  home.packages = with pkgs; [
    audacious
    baobab
    bitwarden
    bottles
    brightnessctl
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
    playerctl
    polkit
    poppler
    pwvucontrol_git
    qalculate-gtk
    radianWrapper
    rclone
    sl
    stix-two
    ventoy-full
    warpinator
    wl-clipboard-rs
    wl-clipboard-x11
    xviewer
    zoom-us
    xfce.catfish
  ];
}
