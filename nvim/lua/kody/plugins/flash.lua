-- Flash.nvim — labeled word jumps (Helix's `gw` parity).
-- Defaults disable `s`/`S`/`r`/`R` bindings because VM claims `s`/`S`
-- and f/F/t/T finding is already handled by treesitter-textobjects+mini.jump.
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = { enabled = false }, -- don't hijack / and ?
      char = { enabled = false },   -- don't enhance f/F/t/T
    },
  },
  keys = {
    { "s", false, mode = { "n", "x", "o" } },
    { "S", false, mode = { "n", "x", "o" } },
    { "r", false, mode = "o" },
    { "R", false, mode = { "o", "x" } },
    { "<c-s>", false, mode = "c" },
    {
      "gw",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash jump (Helix gw)",
    },
  },
}
