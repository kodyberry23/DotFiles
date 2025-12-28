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
        { mode = "x", keys = "[" },
        { mode = "x", keys = "]" },

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
        { mode = "n", keys = "<Leader>l", desc = "+lsp/format" },

        -- Unimpaired navigation
        { mode = "n", keys = "[", desc = "+prev" },
        { mode = "n", keys = "]", desc = "+next" },

        -- Match/surround mode (helix-style)
        { mode = "n", keys = "m", desc = "+match/surround" },
        { mode = "x", keys = "m", desc = "+match/surround" },
        { mode = "n", keys = "mm", desc = "Match brackets" },
        { mode = "n", keys = "mi", desc = "Select inner (→ vi)" },
        { mode = "n", keys = "ma", desc = "Select around (→ va)" },
        { mode = "n", keys = "ms", desc = "Surround add" },
        { mode = "n", keys = "md", desc = "Surround delete" },
        { mode = "n", keys = "mr", desc = "Surround replace" },
        { mode = "x", keys = "mm", desc = "Match brackets" },
        { mode = "x", keys = "ms", desc = "Surround add" },

        -- Visual mode leader clues
        { mode = "x", keys = "<Leader>c", desc = "Toggle comment" },
        { mode = "x", keys = "<Leader>y", desc = "Yank to clipboard" },
        { mode = "x", keys = "<Leader>p", desc = "Paste from clipboard" },
        { mode = "x", keys = "<Leader>P", desc = "Paste before (clipboard)" },
        { mode = "x", keys = "<Leader>C", desc = "Toggle block comment" },
        { mode = "x", keys = "<Leader>R", desc = "Replace from clipboard" },

        -- Visual mode unimpaired
        { mode = "x", keys = "[", desc = "+prev" },
        { mode = "x", keys = "]", desc = "+next" },

        -- vim-visual-multi (multi-cursor/selection) - Helix-style
        -- These are active when VM mode is started with <C-n>
        { mode = "n", keys = "<C-n>", desc = "VM: Start multi-cursor" },
        { mode = "n", keys = "s", desc = "VM: Select regex" },
        { mode = "n", keys = "S", desc = "VM: Split selection" },
        { mode = "n", keys = "<A-s>", desc = "VM: Split on newline" },
        { mode = "n", keys = "<A-minus>", desc = "VM: Merge selections" },
        { mode = "n", keys = "<A-_>", desc = "VM: Merge consecutive" },
        { mode = "n", keys = "&", desc = "VM: Align selections" },
        { mode = "n", keys = "_", desc = "VM: Trim selections" },
        { mode = "n", keys = "<A-;>", desc = "VM: Flip selections" },
        { mode = "n", keys = "<A-:>", desc = "VM: Ensure forward" },
        { mode = "n", keys = ",", desc = "VM: Keep primary" },
        { mode = "n", keys = "<A-,>", desc = "VM: Remove primary" },
        { mode = "n", keys = "(", desc = "VM: Rotate prev" },
        { mode = "n", keys = ")", desc = "VM: Rotate next" },
        { mode = "n", keys = "<A-(>", desc = "VM: Rotate contents prev" },
        { mode = "n", keys = "<A-)>", desc = "VM: Rotate contents next" },
        { mode = "n", keys = "q", desc = "VM: Skip region" },
        { mode = "n", keys = "Q", desc = "VM: Remove region" },
        { mode = "n", keys = "J", desc = "VM: Join lines" },
        { mode = "n", keys = "<A-J>", desc = "VM: Join with space" },
        { mode = "n", keys = "K", desc = "VM: Keep matching / LSP Hover" },
        { mode = "n", keys = "<A-K>", desc = "VM: Remove matching" },
        -- Tree-sitter navigation in VM
        { mode = "n", keys = "<A-o>", desc = "VM: Expand to parent" },
        { mode = "n", keys = "<A-i>", desc = "VM: Shrink to child" },
        { mode = "n", keys = "<A-p>", desc = "VM: Prev sibling" },
        { mode = "n", keys = "<A-n>", desc = "VM: Next sibling" },
        { mode = "n", keys = "<A-a>", desc = "VM: All siblings" },
        { mode = "n", keys = "<A-I>", desc = "VM: All children" },
        { mode = "n", keys = "<A-e>", desc = "VM: Parent end" },
        { mode = "n", keys = "<A-b>", desc = "VM: Parent start" },
        -- Non-VM selection features
        { mode = "n", keys = "%", desc = "Select all" },
        { mode = "n", keys = "x", desc = "Select line" },
        { mode = "n", keys = "X", desc = "Extend to line end" },
        { mode = "v", keys = "<A-x>", desc = "Shrink to line bounds" },
      },
    })
  end,
}
