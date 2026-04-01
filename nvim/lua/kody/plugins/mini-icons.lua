return {
  "echasnovski/mini.icons",
  version = "*",
  lazy = true,
  -- Intercept nvim-web-devicons requires before any plugin loads (LazyVim pattern)
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
  opts = {},
}
