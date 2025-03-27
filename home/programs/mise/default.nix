{ inputs, pkgs, ... }:

{
  programs.mise = {
    enable = true;
    package = inputs.mise-flake.packages.${pkgs.system}.mise;
  };

  xdg.configFile = {
    "mise/config.toml".source = ./config.toml;
    "fish/completions/mise.fish".source = ./mise.fish;
  };
}
