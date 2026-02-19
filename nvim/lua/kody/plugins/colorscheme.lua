return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      hide_fillchars = false,
      borderless_pickers = { telescope = false, snacks = true },
      terminal_colors = true,
      cache = true,
    })
    vim.cmd("colorscheme cyberdream")

    -- Give WinSeparator a bg matching the statusline so the blue vertical
    -- line doesn't bleed through at the junction with laststatus=3
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#5ea1ff", bg = "#1e2124" })

    -- Transparent backgrounds + visible blue borders for Telescope
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#5ea1ff", bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#5ea1ff", bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#5ea1ff", bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#5ea1ff", bg = "NONE" })
  end,
}
