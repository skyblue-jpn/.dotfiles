{ config, pkgs, ... }:

let
  kvantumTheme = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-macchiato-mauve";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "Kvantum";
      rev = "main";
      sha256 = ""; # Replace with actual hash
    };

    installPhase = ''
      mkdir -p $out
      cp -r $src/themes/catppuccin-macchiato-mauve $out/
    '';
  };
in

{
  xdg.configFile = {
    "Kvantum/catppuccin-macchiato-mauve".source = kvantumTheme;
  };
}
