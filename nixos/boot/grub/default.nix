{ config, pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  packages.default = pkgs.stdenv.mkDerivation {
    name = "poly-dark-grub-theme";
    src = pkgs.fetchFromGitHub {
      owner = "shvchk";
      repo = "poly-dark";
      rev = "a3143398a0f3c63b96a79858e10aa403f8fc5152";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    installPhase = ''
      theme_dir=$out/boot/grub/themes/poly-dark
      mkdir -p $theme_dir
      cp -r $src/* $theme_dir/
    '';
  };
}
