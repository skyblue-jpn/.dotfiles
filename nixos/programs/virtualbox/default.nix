{ config, pkgs, ... }:

{
  virtualisation.virtualbox = {
    host.enable = true;
    host.enableExtensionPack = true;
  };
  users.extraGroups.vboxusers.members = [ "celeste" ];
}
