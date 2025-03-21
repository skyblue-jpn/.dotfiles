{ config, pkgs, ... }:

# This patch resolves issues with Kvantum theming on qt5.
# For more details, visit: https://github.com/NixOS/nixpkgs/issues/355277

let
  kvantumTheme = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-macchiato-mauve";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "Kvantum";
      rev = "main";
      sha256 = "sha256-eQmEeKC+L408ajlNg3oKMnDK6Syy2GV6FrR2TN5ZBCg=";
    };

    installPhase = ''
      mkdir -p $out
      cp -r $src/themes/catppuccin-macchiato-mauve/* $out/
    '';
  };
in

{
  xdg.configFile = {
    "Kvantum/catppuccin-macchiato-mauve".source = kvantumTheme;
  };
}
