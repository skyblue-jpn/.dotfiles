{ ... }:

{
  programs.mise = {
    enable = true;
  };

  xdg.configFile = {
    "mise/config.toml".source = ./config.toml;
    "fish/completions/mise.fish".source = ./mise.fish;
  };
}
