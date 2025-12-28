-- Helix-style text object navigation and selection
-- Uses nvim-treesitter-textobjects main branch
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter").setup({
      textobjects = {
        -- Helix-style selection of text objects
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- Helix-aligned text objects
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["at"] = "@class.outer",      -- helix: t = type/class
            ["it"] = "@class.inner",
            ["aa"] = "@parameter.outer",  -- helix: a = argument
            ["ia"] = "@parameter.inner",
            ["ac"] = "@comment.outer",    -- helix: c = comment
            ["ic"] = "@comment.inner",
            ["ab"] = "@block.outer",      -- bonus: b = block
            ["ib"] = "@block.inner",
          },
        },
        -- Helix-style unimpaired navigation
        move = {
          enable = true,
          set_jumps = true,
          -- Helix-style unimpaired navigation
          goto_next_start = {
            ["]f"] = "@function.outer",   -- helix: ]f = next function
            ["]t"] = "@class.outer",      -- helix: ]t = next type/class
            ["]a"] = "@parameter.inner",  -- helix: ]a = next argument
            ["]c"] = "@comment.outer",    -- helix: ]c = next comment
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]T"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",   -- helix: [f = prev function
            ["[t"] = "@class.outer",      -- helix: [t = prev type/class
            ["[a"] = "@parameter.inner",  -- helix: [a = prev argument
            ["[c"] = "@comment.outer",    -- helix: [c = prev comment
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[T"] = "@class.outer",
          },
        },
        -- Swap parameters
        swap = {
          enable = false, -- Disabled: conflicts with vim-visual-multi tree-sitter navigation
          -- Use vim-visual-multi's <A-n>/<A-p> for sibling navigation instead
          -- swap_next = {
          --   ["<A-n>"] = "@parameter.inner",
          -- },
          -- swap_previous = {
          --   ["<A-p>"] = "@parameter.inner",
          -- },
        },
      },
    })

    -- Make movements repeatable with ; and ,
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat last move" })
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Repeat last move (reverse)" })

    -- Make f, F, t, T repeatable
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true, desc = "Find char" })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true, desc = "Find char (backward)" })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true, desc = "Till char" })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true, desc = "Till char (backward)" })
  end,
}
