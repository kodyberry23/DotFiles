return {
  "coder/claudecode.nvim",
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        terminal = {},
      },
    },
  },
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Claude: toggle" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude: focus" },
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Claude: resume" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue" },
    { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: select model" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add buffer" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", desc = "Claude: send selection", mode = "v" },
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: deny diff" },
  },
  opts = {
    auto_start = true,
    terminal = {
      split_side = "right",
      split_width_percentage = 0.30,
      provider = "snacks",
    },
  },
}
