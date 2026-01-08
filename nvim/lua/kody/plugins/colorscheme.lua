return {
  "folke/tokyonight.nvim",
  lazy = false,    -- MUST be false to load at startup
  priority = 1000, -- Load before all other plugins
  opts = {
    style = "storm",
    transparent = true,
    terminal_colors = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    plugins = {
      auto = true,
    },
    on_highlights = function(hl, c)
      hl.WinSeparator = {
        fg = "#7AA2F7",
        bg = "NONE",
      }
      -- Ensure DiffAdd/DiffText also have backgrounds (used by diff tools)
      hl.DiffAdd = { bg = "#2b485a" }    -- Added lines
      hl.DiffText = { bg = "#394b70" }   -- Changed text within a line
      hl.DiffChange = { bg = "#272d43" } -- Changed lines
      hl.DiffDelete = { bg = "#52313f" } -- Deleted lines
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
