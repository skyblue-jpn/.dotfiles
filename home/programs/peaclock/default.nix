{ config, pkgs, ... }:

{
  home.file = {
    ".peaclock/config".source = ./config;
  };
}
