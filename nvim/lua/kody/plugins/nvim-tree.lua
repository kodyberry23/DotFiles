return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<CR>",   desc = "Toggle explorer" },
    { "<leader>ef", "<cmd>NvimTreeFindFile<CR>", desc = "Find in explorer" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse explorer" },
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>",  desc = "Refresh explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      -- Show gitignored files
      git = {
        ignore = false,
      },
      -- Enable real-time filesystem watching
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = { "node_modules", ".git", "dist", "build" },
      },
      -- Auto reload options
      auto_reload_on_write = true,
      reload_on_bufenter = true,
      -- Update focused file automatically
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
      view = {
        width = 40,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
      end,
    })

    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#7AA2F7", bg = "NONE" })
  end,
}
