{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./nix-alien ];
  home.packages = with pkgs; [
    curl
    dotnet-sdk_9
    fontconfig
    freetype
    gcc
    gnumake
    inputs.fix-python.packages.${pkgs.system}.default
    libGL
    libxml2
    openssl
    pkg-config
  ];
}
