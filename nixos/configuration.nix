{ ... }:

{
  nixpkgs.overlays = [
    (import ./overlays/coreutils-fix-overlay.nix)
    (import ./overlays/nixos-rebuild-overlay.nix)
  ];

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
