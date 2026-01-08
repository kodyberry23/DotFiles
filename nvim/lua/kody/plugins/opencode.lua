return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        input = {},
        picker = {},
        terminal = {},
      },
    },
  },
  keys = {
    -- Toggle opencode terminal
    {
      "<leader>oo",
      function()
        require("opencode").toggle()
      end,
      desc = "opencode: toggle",
      mode = { "n", "t" },
    },
    -- Ask with @this context and auto-submit
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      desc = "opencode: ask @this",
      mode = { "n", "x" },
    },
    -- Select/execute an action
    {
      "<leader>ox",
      function()
        require("opencode").select()
      end,
      desc = "opencode: select action",
      mode = { "n", "x" },
    },
    -- Scroll opencode session
    {
      "<leader>ou",
      function()
        require("opencode").command("session.half.page.up")
      end,
      desc = "opencode: half page up",
      mode = "n",
    },
    {
      "<leader>od",
      function()
        require("opencode").command("session.half.page.down")
      end,
      desc = "opencode: half page down",
      mode = "n",
    },
    -- Operator to add range to opencode prompt
    {
      "go",
      function()
        return require("opencode").operator("@this ")
      end,
      desc = "opencode: add range to prompt",
      mode = { "n", "x" },
      expr = true,
    },
    -- Add current line to opencode prompt
    {
      "goo",
      function()
        return require("opencode").operator("@this ") .. "_"
      end,
      desc = "opencode: add line to prompt",
      mode = "n",
      expr = true,
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Provider configuration is handled by opencode CLI config
      -- See ~/.config/opencode/opencode.json
      provider = {
        terminal = {
          split = "right",
          width = math.floor(vim.o.columns * 0.25), -- 25% of screen width (default is 35%)
        },
        snacks = {
          win = {
            position = "right",
            width = 0.25, -- 25% of screen width
          },
        },
      },
    }
    -- Required for file auto-reload after AI edits
    vim.o.autoread = true
  end,
}
