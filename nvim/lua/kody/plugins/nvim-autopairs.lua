return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      typescript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    disable_in_macro = true,
    disable_in_visualblock = false,
    disable_in_replace_mode = true,
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true,
    enable_abbr = false,
    break_undo = true,
    check_comma = true,
    map_cr = false, -- Handled by nvim-cmp
    map_bs = true,
    map_c_h = false,
    map_c_w = false, -- Avoid window nav conflict
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup(opts)

    -- Add spaces between parentheses
    npairs.add_rules({
      Rule(" ", " ")
        :with_pair(function(options)
          local pair = options.line:sub(options.col - 1, options.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(options)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = options.line:sub(col - 1, col + 2)
          return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
        end),
      
      -- Markdown code blocks
      Rule("``````", "markdown"),
    })

    -- Safely disable single quote pairing for lisp-like languages
    local quote_rules = npairs.get_rules("'")
    if quote_rules and quote_rules[1] then
      quote_rules[1].not_filetypes = { "scheme", "lisp", "clojure" }
    end
  end,
}
