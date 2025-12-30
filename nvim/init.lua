-- Disable matchit plugin (we use % for select-all, Helix-style)
vim.g.loaded_matchit = 1

-- Set leader keys BEFORE loading keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("kody.core")
require("kody.lazy")
