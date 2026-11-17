-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- Keep cursor centered when scrolling half-pages or jumping through search results
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down and Center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up and Center" })
map("n", "n", "nzzzv", { desc = "Next Search Result (Centered)" })
map("n", "N", "Nzzzv", { desc = "Prev Search Result (Centered)" })

-- Paste in visual mode without overwriting the default yank register
map("x", "<leader>P", [["_dP]], { desc = "Paste Without Overwriting Register" })
