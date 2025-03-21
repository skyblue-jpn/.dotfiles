{ pkgs, ... }:

{
  imports = [
    ./cups
    ./pipewire
    ./libinput
    #./nix-ld
    ./tools
    ./steam
  ];
}
