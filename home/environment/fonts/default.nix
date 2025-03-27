{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cantarell-fonts
  ];
}
