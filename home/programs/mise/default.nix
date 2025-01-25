{ config, pkgs, inputs, ... }:

{
  programs.mise = {
    enable = true;
    package = inputs.mise-flake.packages.${pkgs.system}.mise;
  };
}
