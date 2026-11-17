local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

---Check whether an executable exists on PATH outside of Mason's bin directory
---(e.g., managed by mise or system package manager).
---@param bin string
---@return boolean
local function has_system_bin(bin)
  local exepath = vim.fn.exepath(bin)
  return exepath ~= "" and not exepath:find(mason_bin, 1, true)
end

return {
  -- Mason: prefer mise/system binaries and support headless auto-upgrades via topgrade
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
    },
    opts = {
      -- Append Mason bin to PATH so mise and system binaries always take precedence
      PATH = "append",
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")

      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      local function sync_mason_packages()
        local installing = {}

        -- 1. Install missing tools from ensure_installed unless already provided by mise/system
        for _, tool in ipairs(opts.ensure_installed or {}) do
          if mr.has_package(tool) then
            local p = mr.get_package(tool)
            local bins = (p.spec and p.spec.bin and vim.tbl_keys(p.spec.bin)) or { tool }
            local provided_by_system = false
            for _, bin in ipairs(bins) do
              if has_system_bin(bin) then
                provided_by_system = true
                break
              end
            end
            if not provided_by_system and not p:is_installed() and not p:is_installing() then
              p:install()
              table.insert(installing, p)
            end
          end
        end

        -- 2. Upgrade any installed Mason packages that have newer versions in the registry
        for _, p in ipairs(mr.get_installed_packages()) do
          local ok_inst, installed_ver = pcall(p.get_installed_version, p)
          local ok_lat, latest_ver = pcall(p.get_latest_version, p)
          if ok_inst and ok_lat and installed_ver and latest_ver and installed_ver ~= latest_ver then
            if not p:is_installing() then
              p:install()
              table.insert(installing, p)
            end
          end
        end

        -- In headless mode (topgrade / bootstrap), wait for installs/upgrades to complete
        if #installing > 0 and #vim.api.nvim_list_uis() == 0 then
          vim.wait(300000, function()
            for _, p in ipairs(installing) do
              if p:is_installing() then
                return false
              end
            end
            return true
          end, 200)
        end
      end

      mr.refresh(sync_mason_packages)
    end,
  },

  -- LSP Configuration aligned with Zed and mise-managed tools
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Configure language servers
      local custom_servers = {
        -- R: use Air (fast Rust LSP) and optional r_language_server from system R
        air = {},
        r_language_server = {
          mason = false,
          root_markers = { "DESCRIPTION", "NAMESPACE", ".Rbuildignore" },
        },

        -- Web / JS / TS / JSON: Biome via mise
        biome = {
          mason = false,
        },

        -- C / C++: clangd via mise/system
        clangd = {
          mason = false,
        },

        -- CMake: neocmake (without requiring Python pip cmakelang)
        neocmake = {},

        -- Markdown: use markdown-oxide (matching Zed) instead of marksman
        marksman = {
          enabled = false,
        },
        markdown_oxide = {},

        -- Python: ruff + ty via mise
        ruff = {
          mason = false,
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
        ty = {
          mason = false,
        },

        -- LaTeX: texlab with tex-fmt and chktex (matching Zed)
        texlab = {
          settings = {
            texlab = {
              build = { onSave = false },
              chktex = { onEdit = true, onOpenAndSave = true },
              latexFormatter = "tex-fmt",
            },
          },
        },

        -- TOML: tombi via mise (replacing taplo)
        taplo = {
          enabled = false,
        },
        tombi = {
          mason = false,
        },
      }

      opts.servers = vim.tbl_deep_extend("force", opts.servers, custom_servers)

      -- Automatically set `mason = false` for any server whose binary is already in mise/system PATH
      local server_bins = {
        air = "air",
        bashls = "bash-language-server",
        biome = "biome",
        clangd = "clangd",
        jsonls = "vscode-json-language-server",
        lua_ls = "lua-language-server",
        markdown_oxide = "markdown-oxide",
        neocmake = "neocmake",
        ruff = "ruff",
        texlab = "texlab",
        tombi = "tombi",
        ty = "ty",
        vtsls = "vtsls",
        yamlls = "yaml-language-server",
      }
      for server, bin in pairs(server_bins) do
        if opts.servers[server] and opts.servers[server].enabled ~= false and has_system_bin(bin) then
          opts.servers[server].mason = false
        end
      end
    end,
  },

  -- Rust: match Zed's rust-analyzer settings and use mise's rust-analyzer
  {
    "mrcjkb/rustaceanvim",
    optional = true,
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            inlayHints = {
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = {
                enable = "skip_trivial",
                useParameterNames = true,
              },
              maxLength = vim.NIL,
            },
            rust = {
              analyzerTargetDir = true,
            },
          },
        },
      },
    },
  },

  -- Formatters aligned with Zed and mise tools
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
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
