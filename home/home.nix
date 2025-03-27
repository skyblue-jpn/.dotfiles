{ pkgs, ... }:

{
  imports = [
    ./desktop
    ./development
    ./environment
    ./packages
    ./programs
    ./scripts
    ./themes
  ];

  home = rec {
    username = "celeste";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
