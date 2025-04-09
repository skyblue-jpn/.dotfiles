{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "macchiato";
        disable_underline = true;
        term_colors = true;
        transparent_background = true;
        styles = {
          booleans = [
            "bold"
            "italic"
          ];
          conditionals = [ "bold" ];
        };
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          treesitter = true;
          notify = false;
          mini = {
            enabled = true;
            indentscope_color = "";
          };
        };
      };
      autoLoad = true;
    };
    plugins = {
      lualine.enable = true;
    };
  };
}
