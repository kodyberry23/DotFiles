return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- Enable treesitter integration
    ts_config = {
      lua = { "string", "source" }, -- Don't add pairs in lua string treesitter nodes
      javascript = { "string", "template_string" },
      java = false, -- Don't check treesitter on java
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    disable_in_macro = true, -- Disable when recording or executing a macro
    disable_in_visualblock = false, -- Disable when in visual block mode
    disable_in_replace_mode = true,
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=], -- Will ignore alphanumeric and special characters
    enable_moveright = true,
    enable_afterquote = true, -- Add bracket pairs after quote
    enable_check_bracket_line = true, -- Check bracket in same line
    enable_bracket_in_quote = true,
    enable_abbr = false, -- Trigger abbreviations
    break_undo = true, -- Switch for basic rule break undo sequence
    check_comma = true,
    map_cr = false, -- Map <CR> (handled by nvim-cmp integration)
    map_bs = true, -- Map backspace
    map_c_h = false, -- Map <C-h>
    map_c_w = false, -- Map <C-w> (conflicts with window nav)
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    npairs.setup(opts)

    -- Add custom rules
    npairs.add_rules({
      -- Add spaces between parentheses (pressing space inside () makes ( | ))
      Rule(" ", " "):with_pair(function(options)
        local pair = options.line:sub(options.col - 1, options.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
      end),

      -- Markdown code blocks
      Rule("```", "```", "markdown"),
    })

    -- For lisp-like languages, disable single quote pairing
    npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "clojure" }
  end,
}
