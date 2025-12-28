return {
  "echasnovski/mini.ai",
  version = "*",
  event = "VeryLazy",
  opts = function()
    local ai = require("mini.ai")
    return {
      -- Number of lines within which textobject is searched
      n_lines = 500,

      -- Custom textobjects using treesitter
      -- These work alongside the default a/i textobjects
      custom_textobjects = {
        -- Function textobjects (treesitter-aware)
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        -- Class textobjects (treesitter-aware)
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        -- Conditional textobjects (treesitter-aware)
        o = ai.gen_spec.treesitter({
          a = { "@conditional.outer", "@loop.outer" },
          i = { "@conditional.inner", "@loop.inner" },
        }, {}),
        -- Parameter/argument textobjects (treesitter-aware)
        a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),
        -- Block textobjects (treesitter-aware)
        b = ai.gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }, {}),
        -- Comment textobjects (treesitter-aware)
        C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
      },
    }
  end,
}
