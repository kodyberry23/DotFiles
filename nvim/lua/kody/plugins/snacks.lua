return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bufdelete = { enabled = true },
    notifier = { enabled = true },
    input = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Neovim user commands must start with uppercase (E183). We define
    -- :Bc / :Bca / :Bco and add command-mode abbreviations so the
    -- lowercase :bc / :bca / :bco work identically — matching Helix.
    local cmds = {
      { "Bc",  function() Snacks.bufdelete() end,       "Close current buffer (Helix :bc)"  },
      { "Bca", function() Snacks.bufdelete.all() end,   "Close all buffers (Helix :bca)"    },
      { "Bco", function() Snacks.bufdelete.other() end, "Close other buffers (Helix :bco)"  },
    }
    for _, c in ipairs(cmds) do
      vim.api.nvim_create_user_command(c[1], c[2], { desc = c[3] })
      -- Expand only when the abbreviation is the entire command (avoids
      -- false matches mid-line like `:! echo bc`).
      vim.cmd(string.format(
        [[cnoreabbrev <expr> %s (getcmdtype() == ':' && getcmdline() ==# '%s') ? '%s' : '%s']],
        c[1]:lower(), c[1]:lower(), c[1], c[1]:lower()
      ))
    end
  end,
}
