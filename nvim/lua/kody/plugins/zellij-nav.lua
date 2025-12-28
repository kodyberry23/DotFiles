return {
  "GR3YH4TT3R93/zellij-nav.nvim",
  cond = os.getenv("ZELLIJ") ~= nil, -- only load inside zellij
  event = "VeryLazy",
  init = function()
    vim.g.zellij_nav_default_mappings = false -- we'll define our own
  end,
  keys = {
    { "<A-h>", "<cmd>ZellijNavigateLeft<CR>",  desc = "Navigate left",  silent = true },
    { "<A-j>", "<cmd>ZellijNavigateDown<CR>",  desc = "Navigate down",  silent = true },
    { "<A-k>", "<cmd>ZellijNavigateUp<CR>",    desc = "Navigate up",    silent = true },
    { "<A-l>", "<cmd>ZellijNavigateRight<CR>", desc = "Navigate right", silent = true },
  },
  opts = {},
}
