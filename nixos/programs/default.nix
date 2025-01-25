{pkgs, ...}:

{
  imports = [
    ./cups.nix
    ./pipewire.nix
    ./libinput.nix
    ./tools.nix
    ./steam.nix
  ];
}
