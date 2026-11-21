local function detect_theme()
  local env_theme = (vim.env.DOTFILES_THEME or ""):lower()
  if env_theme == "nord" or env_theme == "tokyonight" or env_theme == "catppuccin" then
    return env_theme
  end

  local mise_env = (vim.env.MISE_ENV or ""):lower()
  if mise_env:find("theme%-nord") or mise_env:find("sub%-linux") then
    return "nord"
  elseif mise_env:find("theme%-tokyonight") or mise_env:find("work%-wsl") then
    return "tokyonight"
  elseif mise_env:find("theme%-catppuccin") or mise_env:find("home%-main") or mise_env:find("home%-windows") then
    return "catppuccin"
  end

  local starship_real = (vim.uv or vim.loop).fs_realpath(vim.fn.expand("~/.config/starship.toml")) or ""
  if starship_real:find("/themes/nord/", 1, true) or starship_real:find("\\themes\\nord\\", 1, true) then
    return "nord"
  elseif
    starship_real:find("/themes/tokyonight/", 1, true) or starship_real:find("\\themes\\tokyonight\\", 1, true)
  then
    return "tokyonight"
  end

  return "catppuccin"
end

local theme = detect_theme()
local is_nord = theme == "nord"
local is_tokyonight = theme == "tokyonight"

local active_colorscheme = "catppuccin-macchiato"
if is_nord then
  active_colorscheme = "nord"
elseif is_tokyonight then
  active_colorscheme = "tokyonight-night"
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = is_nord or is_tokyonight,
    priority = 1000,
    opts = {
      flavour = "macchiato",
      integrations = {
        blink_cmp = true,
        gitsigns = true,
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
        render_markdown = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      if active_colorscheme == "catppuccin-macchiato" then
        vim.cmd.colorscheme("catppuccin-macchiato")
      end
    end,
  },

  {
    "gbprod/nord.nvim",
    lazy = not is_nord,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("nord").setup(opts)
      if active_colorscheme == "nord" then
        vim.cmd.colorscheme("nord")
      end
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = not is_tokyonight,
    priority = 1000,
    opts = { style = "night" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      if active_colorscheme == "tokyonight-night" then
        vim.cmd.colorscheme("tokyonight-night")
      end
    end,
  },
}
