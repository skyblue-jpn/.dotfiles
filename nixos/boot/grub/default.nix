{ config, pkgs, lib, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  inputs.distro-grub-themes.nixosModules.${system}.default
  distro-grub-themes = {
    enable = true;
    theme = "NixOS";
  };
}
