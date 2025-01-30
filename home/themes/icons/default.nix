{ config, pkgs, ... }:

let
  iconTheme = pkgs.stdenv.mkDerivation {
    pname = "magnetic-catppuccin-gtk-icons-macchiato";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Catppuccin-GTK-Theme";
      rev = "main";
      sha256 = "sha256-QItHmYZpe7BiPC+2CtFwiRXyMTG7+ex0sJTs63xmkAo="; # Replace with actual hash
    };

    installPhase = ''
      mkdir -p $out
      cp -r $src/icons/Catppuccin-Macchiato/* $out/
    '';
  };
in

{
  home.file = {
    ".local/share/icons/magnetic-catppuccin-gtk-icons-macchiato".source = iconTheme;
  };
}
