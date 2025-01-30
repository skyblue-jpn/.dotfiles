{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    clearDefaultKeybinds = false;
  };

  xdg.configFile = {
    "ghostty/configc".source = ./config;
  };
}
