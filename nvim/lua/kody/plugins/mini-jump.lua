return {
  "echasnovski/mini.jump",
  version = "*",
  event = "VeryLazy",
  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      forward = "f",
      backward = "F",
      forward_till = "t",
      backward_till = "T",
      repeat_jump = ";",
    },

    -- Delay values (in ms) for different functionalities
    delay = {
      -- Delay between jump and highlighting all possible jumps
      highlight = 250,

      -- Delay between jump and automatic stop if idle (no jump is done)
      idle_stop = 10000000,
    },
  },
  config = function(_, opts)
    require("mini.jump").setup(opts)
  end,
}
