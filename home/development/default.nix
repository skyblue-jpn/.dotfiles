{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./nix-alien ];
  home.packages = with pkgs; [
    dotnet-sdk_9
    fontconfig
    freetype
    gnumake
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
