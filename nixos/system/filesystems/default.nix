{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-label/windows";
    fsType = "ntfs";
    options = [
      "users"
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
    ];
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-label/storage";
    fsType = "ntfs";
    options = [
      "users"
      "nosuid"
      "nodev"
      "nofail"
      "x-gvfs-show"
    ];
  };
}
