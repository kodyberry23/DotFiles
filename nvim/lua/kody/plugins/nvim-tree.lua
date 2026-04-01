return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "echasnovski/mini.icons",
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
          glyphs = {
            git = {
              untracked = "",
              unstaged = "󰄱",
              staged = "󰱒",
              renamed = "➜",
              deleted = "",
              ignored = "◌",
              unmerged = "",
            },
          },
        },
      },
      view = {
        width = 40,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        
        -- Remove 'ge' mapping (Copy Basename) to avoid conflicts with Helix-style ge (go to end)
        vim.keymap.del("n", "ge", { buffer = bufnr })

        -- Ensure seamless Alt-based navigation in/out of nvim-tree and Zellij panes
        local opts = { buffer = bufnr, silent = true, noremap = true }
        vim.keymap.set("n", "<A-h>", "<cmd>ZellijNavigateLeft<CR>", vim.tbl_extend("force", opts, { desc = "Navigate left" }))
        vim.keymap.set("n", "<A-j>", "<cmd>ZellijNavigateDown<CR>", vim.tbl_extend("force", opts, { desc = "Navigate down" }))
        vim.keymap.set("n", "<A-k>", "<cmd>ZellijNavigateUp<CR>", vim.tbl_extend("force", opts, { desc = "Navigate up" }))
        vim.keymap.set("n", "<A-l>", "<cmd>ZellijNavigateRight<CR>", vim.tbl_extend("force", opts, { desc = "Navigate right" }))
      end,
    })

    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#5ea1ff", bg = "#1e2124" })
    vim.api.nvim_set_hl(0, "NvimTreeStatusLine", { fg = "#1e2124", bg = "#1e2124" })
    vim.api.nvim_set_hl(0, "NvimTreeStatusLineNC", { fg = "#1e2124", bg = "#1e2124" })
  end,
}
