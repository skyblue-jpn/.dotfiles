local is_wsl = vim.env.WSL_DISTRO_NAME ~= nil or vim.env.MISE_ENV == "work-wsl"

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      integrations = {
        blink_cmp = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        noice = true,
        notify = true,
        render_markdown = true,
        snacks = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = is_wsl and "tokyonight-night" or "catppuccin-macchiato",
    },
  },
}
