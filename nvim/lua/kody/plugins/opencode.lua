return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  init = function()
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("opencode.terminal").open("opencode --port", {
            split = "right",
            width = math.floor(vim.o.columns * 0.30),
          })
        end,
      },
    }
    vim.o.autoread = true
  end,
  keys = {
    { "<leader>oo", function() require("opencode").toggle() end, desc = "OpenCode: toggle", mode = { "n", "t" } },
    { "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "OpenCode: ask", mode = { "n", "x" } },
    { "<leader>ox", function() require("opencode").select() end, desc = "OpenCode: actions", mode = { "n", "x" } },
    { "<leader>or", function() require("opencode").command("session.new") end, desc = "OpenCode: new session" },
    { "<leader>os", function() require("opencode").ask("@this: ") end, desc = "OpenCode: send selection", mode = "x" },
  },
}
