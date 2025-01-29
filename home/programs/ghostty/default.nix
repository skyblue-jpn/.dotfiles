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

  home.file.".config/ghostty/config" = {
    source = ./config;
  };
}
