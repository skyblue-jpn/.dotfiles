{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos-rc;
}
