return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
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
          fg = "#c0caf5",  -- Brighter text color for active buffer
          bold = true,
          italic = false,
        },
        offset_separator = {
          fg = "#7AA2F7",
          bg = "NONE",
        },
      },
    })
  end,
}
