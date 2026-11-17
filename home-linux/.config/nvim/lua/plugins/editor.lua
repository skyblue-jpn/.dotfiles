return {
  -- Integrate Yazi file manager directly into Neovim
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open Yazi at current file",
      },
      {
        "<leader>fy",
        "<cmd>Yazi cwd<cr>",
        desc = "Open Yazi in working directory",
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },

  -- Disable legacy node-built markdown-preview in favor of render-markdown.nvim
  { "iamcco/markdown-preview.nvim", enabled = false },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = {
      latex = { enabled = false },
    },
  },

  -- Lazy-load R.nvim only on R/Quarto filetypes and use radian when available
  {
    "R-nvim/R.nvim",
    lazy = true,
    ft = { "r", "rmd", "quarto", "rnoweb" },
    opts = function(_, opts)
      opts = opts or {}
      if vim.fn.executable("radian") == 1 then
        opts.R_app = "radian"
        opts.R_cmd = "R"
        opts.hl_term = false
        opts.bracketed_paste = true
      end
      return opts
    end,
  },

  -- Configure VimTeX with Zathura and LuaLaTeX (matching system pandoc/latex setup)
  {
    "lervag/vimtex",
    init = function()
      if vim.fn.executable("zathura") == 1 then
        vim.g.vimtex_view_method = "zathura"
      end
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-lualatex",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,
  },

  -- Ensure Treesitter parsers for all configured languages and dotfiles are installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "bibtex",
        "c",
        "cmake",
        "cpp",
        "css",
        "diff",
        "fish",
        "git_config",
        "gitcommit",
        "gitignore",
        "graphql",
        "html",
        "ini",
        "javascript",
        "jsdoc",
        "json",
        "kdl",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "nix",
        "powershell",
        "printf",
        "python",
        "query",
        "r",
        "regex",
        "ron",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
  },
}
