{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./nix-alien
    ./R
  ];
  home.packages = with pkgs; [
    dotnet-sdk_9
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
