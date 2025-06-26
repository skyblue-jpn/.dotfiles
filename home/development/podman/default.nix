{ pkgs, inputs, ... }:

{
  imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
  # This is crucial to ensure the systemd services are (re)started on config change
  systemd.user.startServices = "sd-switch";
  virtualisation.quadlet = {
    autoUpdate.enable = true;
    containers = {
      echo-server = {
        autoStart = true;
        serviceConfig = {
          RestartSec = "10";
          Restart = "always";
        };
        #containerConfig = {
        # image = "docker.io/mendhak/http-https-echo:31";
        # publishPorts = [ "127.0.0.1:8080:8080" ];
        # userns = "keep-id";
        # };
      };
    };
  };
}
