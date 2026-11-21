-- Leader keys (must be set before lazy.nvim loads plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.autoformat = true

-- Disable unused remote plugin providers for fast startup and zero healthcheck warnings
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Stub vim.pack so plugins probing vim.pack.get() (e.g. catppuccin auto_integrations),
-- external tools calling vim.pack.update(), and :checkhealth vim.pack do not create
-- ~/.local/share/nvim/site/pack/core/opt when all plugins are managed by lazy.nvim.
local pack_core_opt = vim.fn.stdpath("data") .. "/site/pack/core/opt"
local pack_core = vim.fn.stdpath("data") .. "/site/pack/core"
if vim.fn.isdirectory(pack_core_opt) == 1 and vim.tbl_isempty(vim.fn.readdir(pack_core_opt)) then
  pcall(vim.fn.delete, pack_core_opt, "d")
end
if vim.fn.isdirectory(pack_core) == 1 and vim.tbl_isempty(vim.fn.readdir(pack_core)) then
  pcall(vim.fn.delete, pack_core, "d")
end
package.preload["vim.pack"] = function()
  return {
    add = function() end,
    del = function() end,
    get = function()
      return {}
    end,
    update = function() end,
  }
end
package.preload["vim.pack.health"] = function()
  return {
    check = function()
      vim.health.start("vim.pack")
      vim.health.ok("disabled (plugins managed by lazy.nvim)")
    end,
  }
end

local opt = vim.opt

-- UI & Editor appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 10
opt.winborder = "rounded"
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.mouse = "a"

-- Clipboard (use system clipboard unless over SSH)
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Search & substitute
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

-- Indentation defaults (4 spaces default; 2-space filetypes overridden in autocmds)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- Wrapping & display (matching Zed's soft_wrap = "editor_width")
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true
opt.list = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Folding via Treesitter / LSP
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- File handling, undo & encoding
opt.fileencoding = "utf-8"
opt.fixendofline = true
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.timeoutlen = 300
opt.confirm = true
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Include CJK in spelllang so Japanese text is not flagged as spelling errors
opt.spelllang = { "en", "cjk" }

-- GUI font (matching Zed's HackGen Console)
opt.guifont = "HackGen Console:h14"
