{ pkgs, ... }:

let
  flatpak-gtk = pkgs.stdenv.mkDerivation {
    #  pname = "nixos-artwork-git";
    #  version = "latest";
    #  src = pkgs.fetchFromGitHub {
    #    owner = "NixOS";
    #    repo = "nixos-artwork";
    #    rev = "master";
    #    sha256 = "sha256-VIrSOBCCNq6Fc0dS7XMtC1VebnjRvIUi0/kPal2gWcU=";
    #  };

    #  buildInputs = [
    #    pkgs.imagemagick
    #    pkgs.grub2
    #  ];

    installPhase = ''
      cp -r $src/logo $out/
      cp -r $src/wallpapers $out/
    '';
  };
in
{
  services.flatpak = {
    packages = [
      "com.usebottles.bottles"
    ];
    update.onActivation = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    #   defaultOverrides."*" = { };
  };
}
