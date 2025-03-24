{ config, pkgs, ... }:

{
  virtualisation.virtualbox = {
    host.enable = true;
    host.addNetworkInterface = false;
    host.enableExtensionPack = true;
    host.enableKvm = true;
    guest.enable = false;
    guest.dragAndDrop = true;
    guest.clipboard = true;
  };
  users.extraGroups.vboxusers.members = [ "celeste" ];
}
