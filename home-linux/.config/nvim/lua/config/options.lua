-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Language provider & formatter preferences (matching Zed and mise tools)
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_prettier_needs_config = true
vim.g.autoformat = true

-- Disable unused remote plugin providers for faster startup and clean healthchecks
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt

-- Indentation defaults (4 spaces default; 2-space filetypes overridden in autocmds)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- Wrapping & display (matching Zed's soft_wrap = "editor_width")
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- File handling & encoding
opt.fileencoding = "utf-8"
opt.fixendofline = true
opt.swapfile = false

-- Include CJK in spelllang so Japanese text is not flagged as spelling errors
opt.spelllang = { "en", "cjk" }

-- GUI font (matching Zed's HackGen Console)
opt.guifont = "HackGen Console:h14"
