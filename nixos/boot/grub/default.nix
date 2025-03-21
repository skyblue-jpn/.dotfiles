{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot.loader.grub = lib.mkForce ({
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  });
}
