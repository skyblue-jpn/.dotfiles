{
  home = rec {
    username = "celeste";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
