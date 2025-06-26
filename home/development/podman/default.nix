{ pkgs, inputs, ... }:

{
  imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
  # This is crucial to ensure the systemd services are (re)started on config change
  systemd.user.startServices = "sd-switch";
  virtualisation.quadlet = {
    autoUpdate.enable = true;
    containers = {
      # echo-server container removed due to incomplete configuration
    };
  };
}
