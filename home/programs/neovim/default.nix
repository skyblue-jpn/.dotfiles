{ config, pkgs, ... }:

{
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [ LazyVim ];
  };
}
