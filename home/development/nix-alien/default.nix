{ inputs, system, ... }:

{
  home.packages = with inputs.nix-alien.packages.${system}; [
    nix-alien
  ];
}
