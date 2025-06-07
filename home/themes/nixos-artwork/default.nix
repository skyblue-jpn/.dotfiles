{ config, pkgs, ... }:

let
  nixos-artwork = pkgs.stdenv.mkDerivation {
    pname = "nixos-artwork-git";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixos-artwork";
      rev = "master";
      sha256 = "sha256-eoxlcuO7yi0XTLQCZkEequEduR/WyA2AjWI9y/u+jUI=";
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
