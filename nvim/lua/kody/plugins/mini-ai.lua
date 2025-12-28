return {
  "echasnovski/mini.ai",
  version = "*",
  event = "VeryLazy",
  opts = function()
    local ai = require("mini.ai")
    return {
      -- Number of lines within which textobject is searched
      n_lines = 500,

      -- Use default mappings (a/i) - we wrap with mi/ma in keymaps.lua
      -- https://docs.helix-editor.com/textobjects.html
      mappings = {
        around = "a",
        inside = "i",
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",
        goto_left = "g[",
        goto_right = "g]",
      },

      -- Custom textobjects using treesitter
      -- Helix text objects:
      --   w - word, W - WORD, p - paragraph (built-in vim)
      --   ( ) [ ] { } < > ' " ` - pairs (built-in vim)
      --   m - matching pair (added below)
      --   f - function, t - type, a - argument, c - comment (treesitter)
      --   g - git hunk (gitsigns)
      --
      -- Usage: miw = select inner word, maf = select around function
      custom_textobjects = {
        -- m = matching pair (helix: m) - matches nearest pair (brackets or quotes)
        -- Combines multiple pair types so mim works like vi" or vi( depending on context
        m = {
          { "%b()", "%b[]", "%b{}", '%b""', "%b''", "%b``" },
          "^.().*().$",
        },

        -- f = function (helix: f)
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),

        -- t = type/class (helix: t)
        t = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),

        -- a = argument/parameter (helix: a)
        a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),

        -- c = comment (helix: c)
        c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),

        -- o = conditional/loop (bonus)
        o = ai.gen_spec.treesitter({
          a = { "@conditional.outer", "@loop.outer" },
          i = { "@conditional.inner", "@loop.inner" },
        }, {}),

        -- b = block (bonus)
        b = ai.gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }, {}),

        -- g = git hunk (helix: g)
        -- Uses gitsigns to select the current hunk
        g = function()
          local ok, gitsigns = pcall(require, "gitsigns")
          if ok then
            gitsigns.select_hunk()
          end
        end,
      },
    }
  end,
}
