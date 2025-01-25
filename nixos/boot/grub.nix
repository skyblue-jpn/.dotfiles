{ config, pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
}
