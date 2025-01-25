{ config, pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  home.stateVersion = "23.05"; # Adjust to your Home Manager version
  home.packages = [
    pkgs.stdenv.mkDerivation {
      name = "poly-dark-grub-theme";
      src = poly-dark;
      installPhase = ''
        theme_dir=$out/boot/grub/themes/poly-dark
        mkdir -p $theme_dir
        cp -r $src/* $theme_dir/
      '';
    }
  ];
}
