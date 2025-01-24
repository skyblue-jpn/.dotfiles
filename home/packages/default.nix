{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab
    bitwarden
    bottles
    bottom
    cava
    cbonsai
    efibootmgr
    eza
    fastfetch
    fd
    ffmpeg
    floorp
    #    fzf
    #    gh
    ghostty
    gimp
    gparted
    heroic
    imagemagick
    inkscape
    jq
    libreoffice-fresh
    #    mise
    nixfmt-rfc-style
    p7zip
    peaclock
    pingu
    pipes-rs
    polkit
    poppler
    rclone
    ripgrep
    sddm-astronaut
    sl
    stix-two
    tabby
    topgrade
    ventoy
    vscode
    zoom-us
    zoxide
  ];
}
