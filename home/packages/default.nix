{ pkgs, ... }:

{
  imports = [
    ./flatpak
  ];
  home.packages = with pkgs; [
    audacious
    baobab
    bitwarden
    brightnessctl
    bulky
    cbonsai
    celluloid
    efibootmgr
    ffmpeg
    font-manager
    gimp
    gparted
    imagemagick
    inkscape
    libreoffice-fresh
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
    ventoy-full
    vlc
    warpinator
    wl-clipboard-rs
    wl-clipboard-x11
    xviewer
    # zoom-us
    xfce.catfish
  ];
}
