return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      hide_fillchars = false,
      borderless_pickers = { telescope = true, snacks = true },
      terminal_colors = true,
      cache = true,
    })
    vim.cmd("colorscheme cyberdream")

    -- Give WinSeparator a bg matching the statusline so the blue vertical
    -- line doesn't bleed through at the junction with laststatus=3
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#5ea1ff", bg = "#1e2124" })
  end,
}
