return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- patch cyberdream lualine theme: replace transparent "NONE" backgrounds
    -- with a solid color so the statusline has a visible top border
    local cyberdream_lualine = require("lualine.themes.cyberdream")
    local solid_bg = "#1e2124" -- cyberdream bg_alt
    for _, mode in pairs(cyberdream_lualine) do
      for _, section in pairs(mode) do
        if section.bg == "NONE" then
          section.bg = solid_bg
        end
      end
    end

    lualine.setup({
      options = {
        theme = cyberdream_lualine,
        globalstatus = true,
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ffbd5e" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
      extensions = { "nvim-tree" },
    })
  end,
}
