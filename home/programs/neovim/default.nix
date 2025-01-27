{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      LazyVim
      # Telescope
      ripgrep
    ];
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };
}
