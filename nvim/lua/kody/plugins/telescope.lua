return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    -- Helix-style picker mappings
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>F", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files (hidden)" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>j", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>g", "<cmd>Telescope git_status<cr>", desc = "Changed files" },
    { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    { "<leader>S", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Global search" },
    { "<leader>?", "<cmd>Telescope commands<cr>", desc = "Command palette" },
    { "<leader>d", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>D", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
  },
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules", ".git" },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
