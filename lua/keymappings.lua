local g = vim.g
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
g.mapleader = " "
-- Base Key Mappings
map("n", "<C-s", "<:w<CR>", opts)
map("i", "<C-s", "<ESC> :w<CR>", opts)
-- Nvim Tree
-- map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
-- Telescope
map("n", ";f", ":Telescope find_files<cr>", opts)
map("n", ";r", ":Telescope live_grep<cr>", opts)
map("n", "\\", ":Telescope buffers<cr>", opts)
map("n", ";;", ":Telescope help_tags<cr>", opts)
-- Lspsaga
-- map('n', '<C-u>', '<CMD>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)
-- map('n', '<C-d>', '<CMD>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
