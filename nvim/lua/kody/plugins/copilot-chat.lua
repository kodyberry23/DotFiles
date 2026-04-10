return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  keys = {
    { "<leader>oo", "<cmd>CopilotChatToggle<cr>", desc = "Copilot: toggle", mode = { "n", "t" } },
    {
      "<leader>oa",
      function()
        local input = vim.fn.input("Copilot: ")
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end,
      desc = "Copilot: ask",
      mode = { "n", "x" },
    },
    {
      "<leader>ox",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      desc = "Copilot: prompt actions",
      mode = { "n", "x" },
    },
    { "<leader>or", "<cmd>CopilotChatReset<cr>", desc = "Copilot: reset" },
  },
  opts = {
    window = {
      layout = "vertical",
      width = 0.25,
      border = "rounded",
    },
  },
}
