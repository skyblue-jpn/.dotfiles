{ ... }:

{
  programs.ghostty = {
    enable = true;
    installBatSyntax = true;
    installVimSyntax = true;
    clearDefaultKeybinds = false;
  };

  xdg.configFile = {
    "ghostty/config".source = ./config;
  };
}
