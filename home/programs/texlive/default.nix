{ config, pkgs, ... }:

{
  programs.texlive = {
    enable = true;
    packageSet = pkgs.texliveFull;
  };
}
