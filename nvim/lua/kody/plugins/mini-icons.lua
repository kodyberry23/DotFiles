return {
  "echasnovski/mini.icons",
  version = "*",
  lazy = false,
  priority = 900, -- Load after colorscheme (1000) but before other plugins
  config = function()
    require("mini.icons").setup()
    -- Drop-in replacement: plugins that expect nvim-web-devicons just work
    MiniIcons.mock_nvim_web_devicons()
  end,
}
