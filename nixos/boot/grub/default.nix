{ config, pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  environment.systemPackages = with pkgs; [
    (pkgs.runCommand "install-poly-dark-grub-theme" {} ''
      wget -O - https://github.com/shvchk/poly-dark/raw/master/install.sh | bash
    '')
  ];
}
