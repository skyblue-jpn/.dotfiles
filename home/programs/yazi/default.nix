{ config, pkgs, inputs, ... }:

{
  programs.yazi = {
    enable = true;
    package = yazi.packages.${pkgs.system}.default;
  };
}
