{ config, pkgs, ... }:

{
  home = rec {
    username = "celeste";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    stix-two
    sddm-astronaut
    vscode
    ghostty
    polkit
    nixfmt-rfc-style
    gh
    baobab
    bitwarden
    p7zip
    bottom
    bottles
    cava
    cbonsai
    efibootmgr
    eza
    fastfetch
    fd
    ffmpeg
    floorp
    fzf
    gimp
    gparted
    heroic
    imagemagick
    inkscape
    jq
    libreoffice-fresh
    mise
    peaclock
    pingu
    pipes-rs
    poppler
    rclone
    ripgrep
    sl
    tabby
    topgrade
    ventoy
    zoom-us
    zoxide
  ];
}
