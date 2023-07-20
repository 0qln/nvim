vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
  
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
  
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

vim.keymap.set("n", "<C-W>+", function() vim.cmd("vs") end)
vim.keymap.set("n", "<C-W>-", function() vim.cmd("sp") end)

vim.keymap.set("n", "O", "o<Esc>k")

--vim.keymap.set("n", "<A-j>", function() require() end)
vim.keymap.set("n", "<C-l>", "<C-Right>")
vim.keymap.set("n", "<C-h>", "<C-Left>")
vim.keymap.set("n", "<C-j>", function() for i=0, 9 do feedKeys("n", "j") end end)
vim.keymap.set("n", "<C-k>", function() for i=0, 9 do feedKeys("n", "k") end end)
vim.keymap.set("v", "<C-j>", function() for i=0, 9 do feedKeys("v", "j") end end)
vim.keymap.set("v", "<C-k>", function() for i=0, 9 do feedKeys("v", "k") end end)
vim.keymap.set("v", "<C-h>", function() feedKeys("n", "<C-Left>") end)
vim.keymap.set("v", "<C-l>", function() feedKeys("n", "<C-Right>") end)


vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

function feedKeys(mode, keys) 
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end
