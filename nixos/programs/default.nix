{ pkgs, ... }:

{
  imports = [
    ./cups
    ./pipewire
    ./libinput
    ./tools
    ./steam
  ];
}
