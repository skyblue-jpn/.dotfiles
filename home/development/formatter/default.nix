{ pkgs, ... }:

{
  home.packages = with pkgs; [
    treefmt
    nixfmt-rfc-style
    biome
    nodePackages.prettier
    ruff
    shfmt
    taplo
    yamlfmt
  ];
  # adding treefmt for vscode conf
  home.file = {
    "treefmt.toml".source = ./treefmt.toml;
  };
}
