{ config, pkgs, ... }:

let
  nixos-artwork = pkgs.stdenv.mkDerivation {
    pname = "nixos-artwork-git";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixos-artwork";
      rev = "master";
      sha256 = "sha256-9PCkx6Rn9v4/k7obMI9jl+4L8sVesEJFT8EC/I0OMZw=";
    };

    buildInputs = [
      pkgs.imagemagick
      pkgs.grub2
    ];

    installPhase = ''
      mkdir -p $out
      cp -r $src/logo $out/
      cp -r $src/wallpapers $out/
    '';
  };
in

{
  home.file = {
    "nixos-artwork".source = nixos-artwork;
  };
}
