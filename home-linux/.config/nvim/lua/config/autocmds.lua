-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Automatically apply plugin updates in the background when lazy.nvim detects them
vim.api.nvim_create_autocmd("User", {
  group = augroup("lazy_auto_update"),
  pattern = "LazyCheck",
  callback = function()
    local checker = require("lazy.manage.checker")
    if #checker.updated > 0 and not vim.tbl_isempty(vim.api.nvim_list_uis()) then
      require("lazy").update({ show = false })
    end
  end,
})

-- Use 2-space indentation for web, config, shell, and markup languages (matching Zed config)
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("two_space_indent"),
  pattern = {
    "bib",
    "cmake",
    "css",
    "fish",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "kdl",
    "lua",
    "markdown",
    "markdown.mdx",
    "nix",
    "plaintex",
    "r",
    "scss",
    "sh",
    "tex",
    "toml",
    "typescript",
    "typescriptreact",
    "xml",
    "yaml",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Trim trailing whitespace on save (matching Zed's remove_trailing_whitespace_on_save)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  callback = function(event)
    local bo = vim.bo[event.buf]
    if not bo.modifiable or bo.binary or bo.buftype ~= "" then
      return
    end
    -- Preserve trailing spaces in Markdown and diff files
    if vim.tbl_contains({ "markdown", "markdown.mdx", "diff", "gitcommit" }, bo.filetype) then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Automatically deactivate fcitx5 IME when leaving Insert or Cmdline mode
if vim.fn.executable("fcitx5-remote") == 1 then
  vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
    group = augroup("fcitx5_im_off"),
    callback = function()
      vim.system({ "fcitx5-remote", "-c" })
    end,
  })
end
