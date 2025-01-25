{
  imports = [
    ./fonts.nix
    ./locale.nix
    ./input-method.nix
  ];
  environment.sessionVariables = {
    BROWSER = "floorp";
    TERMINAL = "ghostty";
  };
}
