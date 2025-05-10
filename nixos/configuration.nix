{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot
    ./desktop
    ./environment
    ./programs
    ./system
    ./themes
    ./users
  ];
}
