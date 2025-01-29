{ pkgs, ... }:

{
  nix.package = pkgs.nix;

  imports = [
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
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

}
