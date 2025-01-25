{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sleek-grub-theme
  ];
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    theme = "${pkgs.sleek-grub-theme}/grub/themes/sleek";
  };

}
