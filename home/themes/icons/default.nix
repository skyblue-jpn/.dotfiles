{ config, pkgs, ... }:

let
  iconTheme = pkgs.stdenv.mkDerivation {
    pname = "magnetic-catppuccin-gtk-icons-macchiato";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Catppuccin-GTK-Theme";
      rev = "main";
      sha256 = ""; # Replace with actual hash
    };

    installPhase = ''
      mkdir -p $out
      cp -r $src/icons/Catppuccin-Macchiato/* $out/
    '';
  };
in

{
  home.file = {
    ".local/share/icons/Catppuccin-Macchiato".source = iconTheme;
  };
}
