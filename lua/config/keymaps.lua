-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Center after up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Continue last telescope search
-- vim.keymap.set(
--   "n",
--   "<leader>sn",
--   require("telescope.builtin").resume,
--   { noremap = true, silent = true, desc = "Continue last search" },
-- )
