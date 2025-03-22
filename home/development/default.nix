{ lib, pkgs, ... }:

{
  imports = [ ./nix-alien ];
  home.packages = with pkgs; [
    dotnet-sdk_9
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
