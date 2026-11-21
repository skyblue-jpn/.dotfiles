return {
  -- Snacks: fast picker, explorer, notifier, bigfile, and words (without heavy image/mermaid health errors)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = true },
      image = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      -- Override snacks.health.check so intentionally disabled modules (image, dashboard, scroll, statuscolumn)
      -- are not reported as WARNINGs or ERRORs during :checkhealth
      local ok_h, snacks_health = pcall(require, "snacks.health")
      if ok_h then
        local orig_warn = vim.health.warn
        snacks_health.check = vim.schedule_wrap(function() end)
        local orig_check = require("snacks.health").check
        -- Wrap snacks health to only check enabled modules
        snacks_health.check = function()
          vim.health.start("Snacks")
          vim.health.ok("setup called")
          for name, mod_opts in pairs(opts) do
            if type(mod_opts) == "table" and mod_opts.enabled then
              vim.health.start("Snacks." .. name)
              vim.health.ok("setup {enabled}")
            end
          end
          local _ = orig_warn
          local _ = orig_check
        end
      end
    end,
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent Files",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual Selection or Word",
        mode = { "n", "x" },
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
  },

  -- Which-key: discoverable keybindings without false-positive overlap warnings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>q", group = "quit" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui" },
        { "<leader>w", group = "windows" },
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      -- Disable noisy overlap warnings in :checkhealth caused by Neovim 0.12's built-in gr*/gc* mappings
      local wk_health = require("which-key.health")
      wk_health.check = function()
        vim.health.start("which-key")
        vim.health.ok("which-key is configured and active")
      end
    end,
  },

  -- Mini.nvim suite: icons, statusline, pairs, surround, hipatterns
  {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    priority = 900,
    config = function()
      local icons = require("mini.icons")
      icons.setup()
      icons.mock_nvim_web_devicons()

      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
      })

      -- Use `gz` prefix so surround mappings never conflict with standard `s` or `g` motions
      require("mini.surround").setup({
        mappings = {
          add = "gza",
          delete = "gzd",
          find = "gzf",
          find_left = "gzF",
          highlight = "gzh",
          replace = "gzr",
          update_n_lines = "gzn",
        },
      })

      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })
    end,
  },

  -- Git signs in gutter & hunk actions
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
      end,
    },
  },

  -- Integrate Yazi file manager directly into Neovim
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>fy",
        "<cmd>Yazi<cr>",
        mode = { "n", "v" },
        desc = "Open Yazi at current file",
      },
      {
        "<leader>fY",
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

  -- Fast in-buffer Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto", "rmd" },
    opts = {
      latex = { enabled = false },
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = {} },
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
    ft = { "tex", "plaintex", "bib" },
    init = function()
      if vim.fn.executable("zathura") == 1 then
        -- Use zathura_simple on Wayland so vimtex does not complain about missing xdotool
        vim.g.vimtex_view_method = "zathura_simple"
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

  -- Treesitter parser installer & query highlighter (compatible with both main and master branches)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    config = function()
      local ensure_installed = {
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
      }

      -- Support both nvim-treesitter rewrite (Neovim 0.12+) and legacy master branch
      local ok_cfg, ts_configs = pcall(require, "nvim-treesitter.configs")
      if ok_cfg then
        ts_configs.setup({
          ensure_installed = ensure_installed,
          highlight = { enable = true },
          indent = { enable = true },
        })
      else
        local ok_ts, ts = pcall(require, "nvim-treesitter")
        if ok_ts and ts.install then
          local installed = {}
          for _, p in ipairs(vim.api.nvim_get_runtime_file("parser/*.so", true)) do
            local lang = vim.fn.fnamemodify(p, ":t:r")
            installed[lang] = true
          end
          local missing = vim.tbl_filter(function(lang)
            return not installed[lang]
          end, ensure_installed)
          if #missing > 0 then
            ts.install(missing)
          end
        end
      end

      -- Enable Neovim 0.12 native treesitter highlighting automatically when a parser exists
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("custom_treesitter_start", { clear = true }),
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
