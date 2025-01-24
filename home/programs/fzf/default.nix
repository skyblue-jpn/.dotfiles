{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    keybindings = true;
    fuzzyCompletion = true;
  };
}
