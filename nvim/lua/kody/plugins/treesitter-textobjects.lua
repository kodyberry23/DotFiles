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
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["aC"] = "@comment.outer",
            ["iC"] = "@comment.inner",
          },
        },
        -- Helix-style unimpaired navigation
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]t"] = "@class.outer",
            ["]a"] = "@parameter.inner",
            ["]c"] = "@comment.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]T"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[t"] = "@class.outer",
            ["[a"] = "@parameter.inner",
            ["[c"] = "@comment.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[T"] = "@class.outer",
          },
        },
        -- Swap parameters
        swap = {
          enable = true,
          swap_next = {
            ["<A-n>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<A-p>"] = "@parameter.inner",
          },
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
