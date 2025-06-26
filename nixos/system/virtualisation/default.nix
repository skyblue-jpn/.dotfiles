{ ... }:

{
  imports = [
    ./podman
    ./virtualbox
  ];

  virtualisation.containers.enable = true;
}
