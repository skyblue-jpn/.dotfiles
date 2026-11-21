return {
  -- Blink.cmp: blazing fast Rust-powered completion engine
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = false,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        enabled = true,
      },
    },
  },

  -- Neovim 0.12 native vim.lsp.config + nvim-lspconfig server definitions (100% mise-managed, zero Mason)
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 800,
    config = function()
      -- Diagnostic UI styling
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      -- Buffer-local LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("custom_lsp_attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", function()
            if _G.Snacks then
              Snacks.picker.lsp_definitions()
            else
              vim.lsp.buf.definition()
            end
          end, "Goto Definition")
          map("gr", function()
            if _G.Snacks then
              Snacks.picker.lsp_references()
            else
              vim.lsp.buf.references()
            end
          end, "References")
          map("gI", function()
            if _G.Snacks then
              Snacks.picker.lsp_implementations()
            else
              vim.lsp.buf.implementation()
            end
          end, "Goto Implementation")
          map("gy", function()
            if _G.Snacks then
              Snacks.picker.lsp_type_definitions()
            else
              vim.lsp.buf.type_definition()
            end
          end, "Goto Type Definition")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gK", vim.lsp.buf.signature_help, "Signature Help")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
          map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
          end, "Toggle Inlay Hints")
        end,
      })

      -- Server configurations aligned with Zed settings.json and mise tools
      local servers = {
        air = { bin = "air" },
        bashls = { bin = "bash-language-server" },
        biome = { bin = "biome" },
        clangd = {
          bin = "clangd",
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
        jsonls = { bin = "vscode-json-language-server" },
        lua_ls = {
          bin = "lua-language-server",
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
              diagnostics = { globals = { "vim", "Snacks" } },
              telemetry = { enable = false },
            },
          },
        },
        markdown_oxide = { bin = "markdown-oxide" },
        neocmake = { bin = "neocmakelsp" },
        r_language_server = {
          bin = "R",
          root_markers = { "DESCRIPTION", "NAMESPACE", ".Rbuildignore" },
        },
        ruff = {
          bin = "ruff",
          init_options = {
            settings = {
              lineLength = 80,
              organizeImports = true,
              fixAll = true,
              lint = { enable = true, preview = true },
              format = { preview = true },
            },
          },
        },
        rust_analyzer = {
          bin = "rust-analyzer",
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = {
                  enable = "skip_trivial",
                  useParameterNames = true,
                },
              },
              rust = {
                analyzerTargetDir = true,
              },
            },
          },
        },
        texlab = {
          bin = "texlab",
          settings = {
            texlab = {
              build = { onSave = false },
              chktex = { onEdit = true, onOpenAndSave = true },
              latexFormatter = "tex-fmt",
            },
          },
        },
        tombi = { bin = "tombi" },
        ty = { bin = "ty" },
        vtsls = { bin = "vtsls" },
        yamlls = {
          bin = "yaml-language-server",
          settings = {
            yaml = {
              format = { enable = true, singleQuote = false },
              keyOrdering = true,
            },
          },
        },
      }

      -- Enable only servers whose binaries exist on PATH (managed by mise / system)
      for name, cfg in pairs(servers) do
        local bin = cfg.bin
        cfg.bin = nil
        if vim.fn.executable(bin) == 1 then
          vim.lsp.config(name, cfg)
          vim.lsp.enable(name)
        end
      end
    end,
  },

  -- Formatters aligned with Zed and mise tools
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format Buffer",
      },
    },
    opts = {
      format_on_save = function(bufnr)
        if not vim.g.autoformat or vim.b[bufnr].autoformat == false then
          return
        end
        return { timeout_ms = 2000, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        bash = { "shfmt" },
        bib = { "bibtex-tidy" },
        css = { "biome-check" },
        fish = { "fish_indent" },
        graphql = { "biome-check" },
        html = { "biome-check" },
        javascript = { "biome-check" },
        javascriptreact = { "biome-check" },
        json = { "biome-check" },
        jsonc = { "biome-check" },
        lua = { "stylua" },
        plaintex = { "tex-fmt" },
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        r = { "air" },
        sh = { "shfmt" },
        tex = { "tex-fmt" },
        toml = { "tombi" },
        typescript = { "biome-check" },
        typescriptreact = { "biome-check" },
      },
      formatters = {
        ["bibtex-tidy"] = {
          prepend_args = {
            "--curly",
            "--numeric",
            "--months",
            "--space=2",
            "--align=14",
            "--sort-fields",
            "--no-sort",
            "--no-escape",
            "--no-encode-urls",
            "--no-wrap",
            "--trailing-commas",
          },
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
  },
}
