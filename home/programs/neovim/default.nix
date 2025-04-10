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
      bufferline.enable = true;
      colorful-menu.enable = true;
      conform-nvim.enable = true;
      flash.enable = true;
      gitsigns.enable = true;
      grug-far.enable = true;
      lazy.enable = true;
      lazydev.enable = true;
      lsp.enable = true;
      lsp-format.enable = true;
      lualine.enable = true;
      mini = {
        enable = true;
        mockDevIcons = true;
        modules.icons = { };
      };
      noice.enable = true;
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
      notify.enable = true;
      nui.enable = true;
      persistence.enable = true;
      snacks.enable = true;
      telescope.enable = true;
      todo-comments.enable = true;
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
      trouble.enable = true;
      ts-comments.enable = true;
      which-key.enable = true;
      yazi.enable = true;
    };
  };
}
