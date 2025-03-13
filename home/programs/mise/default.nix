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
    "fish/completions/mise.fish".source = builtins.toString ''
      mise completion fish
    '';
  };
}
