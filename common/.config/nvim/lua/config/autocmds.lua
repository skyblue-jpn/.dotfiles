local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Restore cursor to last known location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].custom_last_loc then
      return
    end
    vim.b[buf].custom_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close helper filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(event.buf) then
        return
      end
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Automatically create missing parent directories when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = (vim.uv or vim.loop).fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Clean up empty site/pack/core directory created during VimEnter so lazy.nvim and vim.pack healthchecks stay clean
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("cleanup_empty_pack_core"),
  callback = function()
    local pack_core_opt = vim.fn.stdpath("data") .. "/site/pack/core/opt"
    local pack_core = vim.fn.stdpath("data") .. "/site/pack/core"
    if vim.fn.isdirectory(pack_core_opt) == 1 and vim.tbl_isempty(vim.fn.readdir(pack_core_opt)) then
      pcall(vim.fn.delete, pack_core_opt, "d")
    end
    if vim.fn.isdirectory(pack_core) == 1 and vim.tbl_isempty(vim.fn.readdir(pack_core)) then
      pcall(vim.fn.delete, pack_core, "d")
    end
  end,
})

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
    "bash",
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
