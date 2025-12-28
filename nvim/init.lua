-- Disable matchit plugin (we use % for select-all, Helix-style)
vim.g.loaded_matchit = 1

require("kody.core")
require("kody.lazy")
