{ lib, pkgs, ... }:

{
  imports = [ ./nix-alien ];
  home.packages = with pkgs; [
    dotnet-sdk_9
  ];
}
