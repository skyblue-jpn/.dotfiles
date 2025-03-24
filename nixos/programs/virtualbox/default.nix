{ config, pkgs, ... }:

{
  virtualisation.virtualbox = {
    host.enable = true;
    host.enableExtensionPack = true;
    host.enableKvm = true;
    guest.enable = true;
    guest.dragAndDrop = true;
    guest.clipboard = true;
  };
  users.extraGroups.vboxusers.members = [ "celeste" ];
}
