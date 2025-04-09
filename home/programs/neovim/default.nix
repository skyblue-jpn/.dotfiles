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
    };
    plugins = {
      lazy.enable = true;
      bufferline.enable = true;
      colorful-menu.enable = true;
      lualine.enable = true;
      noice.enable = true;
      mini = {
        enable = true;
        modules.icons = { };
        mockDevIcons = true;
      };
      nui.enable = true;
      snacks.enable = true;
      ts-comments.enable = true;
      lazydev.enable = true;
      grug-far.enable = true;
      flash.enable = true;
      which-key.enable = true;
      gitsigns.enable = true;
      trouble.enable = true;
      todo-comments.enable = true;
      conform-nvim.enable = true;
      lsp.enable = true;
      lsp-format.enable = true;
      none-ls = {
        enable = true;
        sources.completion = {
          luasnip.enable = true;
          spell.enable = true;
          tags.enable = true;
        };
        sources.diagnostics = {
          markdownlint.enable = true;
        };
        sources.formatting = {
          nixfmt.enable = true;
          nixfmt.package = pkgs.nixfmt-rfc-style;
          prettierd.enable = true;
        };
      };
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };
      persistence.enable = true;
      yazi.enable = true;
      telescope.enable = true;
    };
  };
}
