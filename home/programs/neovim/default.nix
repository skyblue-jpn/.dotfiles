{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
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
