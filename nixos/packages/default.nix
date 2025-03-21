{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    nixos-generators
  ];
}
