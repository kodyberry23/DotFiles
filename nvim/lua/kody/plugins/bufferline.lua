return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = "echasnovski/mini.icons",
  config = function()
    require("bufferline").setup({
      options = {
        indicator = {
          style = "none",  -- No indicator
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          },
        },
      },
      highlights = {
        buffer_selected = {
          fg = "#ffffff",  -- Brighter text color for active buffer
          bg = "#16181a",
          bold = true,
          italic = false,
        },
        offset_separator = {
          fg = "#5ea1ff",
          bg = "NONE",
        },
      },
    })
  end,
}
