{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.mise = {
    enable = true;
    #    package = inputs.mise-flake.packages.${pkgs.system}.mise;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  xdg.configFile = {
    "mise/config.toml".source = ./config.toml;
    "fish/completions/mise.fish".source = ./mise.fish;
  };

  home.file = {
    "mise-builder/flake.nix".source = ./mise-builder/flake.nix;
    "mise-builder/mise.toml".source = ./mise-builder/mise.toml;
  };
}
