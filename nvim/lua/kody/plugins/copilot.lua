return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  keys = {
    { "<leader>ot", "<cmd>Copilot toggle<cr>", desc = "Copilot: toggle" },
    { "<leader>os", "<cmd>Copilot status<cr>", desc = "Copilot: status" },
    { "<leader>op", "<cmd>Copilot panel<cr>", desc = "Copilot: panel" },
  },
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    panel = {
      enabled = true,
    },
  },
}
