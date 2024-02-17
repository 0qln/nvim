--=--
-- 
-- The z character as a mark is reserved for dynamically used marks.
-- Do not use as mark!
-- 
--=--


-- Define leader
vim.g.mapleader = " "


-- Test editing
vim.keymap.set("v", "J", ":m '>+1<CR>gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--vim.keymap.set("n", "<C-j>", "nzzzv")
--vim.keymap.set("n", "<C-k>", "Nzzzv")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<F2>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Keeping all comment keywords the same width makes uncommenting easy. Do not change!
vim.keymap.set("n", "<C-c>/", "mzI// <Esc>`z")
vim.keymap.set("n", "<C-c>-", "mzI-- <Esc>`z") 
vim.keymap.set("n", "<C-c>#", "mzI#  <Esc>`z") 
vim.keymap.set("n", "<C-c>u", "mzI<Del><Del><Del><Esc>`z")

vim.keymap.set("v", "<C-c>/", ":'<,'>normal! mzI// <Esc>`z")
vim.keymap.set("v", "<C-c>-", ":'<,'>normal! mzI-- <Esc>`z")
vim.keymap.set("v", "<C-c>#", ":'<,'>normal! mzI#  <Esc>`z")
vim.keymap.set("v", "<C-c>u", ":'<,'>normal! mzI<Del><Del><Del><Esc>`z")

-- What was this supposed to do, Neovim?
vim.keymap.set("n", "Q", "<nop>")
  

-- MISC
vim.keymap.set("n", "<leader><C-g>", function() vim.cmd("lua print(vim.loop.cwd())") end)
vim.keymap.set("n", "<leader>mr", function() vim.cmd("CellularAutomaton make_it_rain") end)
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)
vim.keymap.set("n", "<Enter>", function() feedKeys("n", "mzo<Esc>`/") end)
--vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


-- Window Navigation
vim.keymap.set("n", "<C-w><BS>", function() vim.cmd("q") end)
vim.keymap.set("n", "<C-w>=", function() vim.cmd("vs") end)
vim.keymap.set("n", "<C-w>-", function() vim.cmd("sp") end)
-- File Navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)



-- Unused old remaps to make navigation more like in a IDE with arrows and <C-arrows>
-- vim.keymap.set("n", "<C-l>", "<C-Right>")
-- vim.keymap.set("n", "<C-h>", "<C-Left>")
-- vim.keymap.set("n", "<C-j>", function() for i=0, 9 do feedKeys("n", "j") end end)
-- vim.keymap.set("n", "<C-k>", function() for i=0, 9 do feedKeys("n", "k") end end)
-- vim.keymap.set("v", "<C-j>", function() for i=0, 9 do feedKeys("v", "j") end end)
-- vim.keymap.set("v", "<C-k>", function() for i=0, 9 do feedKeys("v", "k") end end)
-- vim.keymap.set("v", "<C-h>", function() feedKeys("n", "<C-Left>") end)
-- vim.keymap.set("v", "<C-l>", function() feedKeys("n", "<C-Right>") end)


-- Folds control
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        vim.lsp.buf.hover()
    end
end)

function feedKeys(mode, keys) 
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end
