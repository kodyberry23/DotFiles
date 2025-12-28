return {
  "echasnovski/mini.clue",
  version = "*",
  event = "VeryLazy",
  config = function()
    local miniclue = require("mini.clue")
    miniclue.setup({
      -- Clue window settings
      window = {
        delay = 300,  -- Delay before showing clue window (ms)
        config = {
          width = "auto",
          border = "rounded",
        },
      },

      -- Triggers are key sequences that will show clues
      triggers = {
        -- Leader key triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key (goto mode)
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key (view mode)
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },

        -- Unimpaired-style navigation
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        -- Match/surround mode
        { mode = "n", keys = "m" },
        { mode = "x", keys = "m" },
      },

      -- Clue definitions
      clues = {
        -- Built-in clue generators
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),

        -- Custom clues for leader key groups
        { mode = "n", keys = "<Leader>w", desc = "+window" },
        { mode = "n", keys = "<Leader>q", desc = "+quit" },
        { mode = "n", keys = "<Leader>b", desc = "+buffer" },
        { mode = "n", keys = "<Leader>h", desc = "+git hunk" },
        { mode = "n", keys = "<Leader>u", desc = "+ui/toggle" },
        { mode = "n", keys = "<Leader>t", desc = "+toggle" },

        -- Unimpaired navigation
        { mode = "n", keys = "[", desc = "+prev" },
        { mode = "n", keys = "]", desc = "+next" },

        -- Match/surround mode
        { mode = "n", keys = "m", desc = "+match/surround" },
      },
    })
  end,
}
