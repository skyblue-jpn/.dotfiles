{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
}
