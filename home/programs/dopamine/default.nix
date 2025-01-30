{ config, pkgs, ... }:

let
  dopamineTheme = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-macchiato";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "dopamine";
      rev = "main";
      sha256 = "";
    };

    installPhase = ''
      mkdir -p $out
      cp -r $src/macchiato/* $out/
    '';
  };
in

{
  home.packages = [ pkgs.dopamine ];

  xdg.configFile = {
    "Dopamine/config.json".source = ./config.json;
    "Dopamine/Themes".source = dopamineTheme;
  };
}
