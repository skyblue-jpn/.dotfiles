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
    font-manager
    gimp3
    gparted
    imagemagick
    inkscape
    nemo-with-extensions
    p7zip
    peaclock
    pipes-rs
    pix
    playerctl
    polkit
    poppler
    pwvucontrol_git
    qalculate-gtk
    rclone
    s-tui
    sl
    stix-two
    # ventoy-full-gtk
    vlc
    warpinator
    wl-clipboard-rs
    wl-clipboard-x11
    wpsoffice
    xviewer
    zoom-us
    xfce.catfish
  ];
}
