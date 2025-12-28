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
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
