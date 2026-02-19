-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- Disable matchit plugin (we use % for select-all, Helix-style)
vim.g.loaded_matchit = 1

-- Disable netrw (using nvim-tree and oil.nvim instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader keys BEFORE loading keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("kody.core")
require("kody.lazy")
