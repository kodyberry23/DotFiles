return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo", "Format", "FormatToggle" },
  keys = {
    { "<leader>lf", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
    { "<leader>lF", function() require("conform").format({ async = true, range = true }) end, mode = "v", desc = "Format range" },
  },
  opts = {
    -- Formatters by filetype
    -- https://github.com/stevearc/conform.nvim#formatters
    formatters_by_ft = {
      -- Lua
      lua = { "stylua" },

      -- JavaScript/TypeScript
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },

      -- Web
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },

      -- Go
      go = { "goimports", "gofmt" },

      -- Rust (use rustfmt, fallback to LSP)
      rust = { "rustfmt", lsp_format = "fallback" },

      -- Python
      python = { "ruff_format", "black", stop_after_first = true },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },

      -- Elixir
      elixir = { "mix" },
      heex = { "mix" },
      eelixir = { "mix" },

      -- Erlang
      erlang = { "erlfmt" },

      -- Java
      java = { "google-java-format" },

      -- Fallback: trim whitespace for all files
      ["_"] = { "trim_whitespace" },
    },

    -- Default format options
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 3000,
    },

    -- Notify when no formatters available
    notify_on_error = true,
    notify_no_formatters = true,
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)

    -- Create :Format command with autocompletion
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      conform.format({
        async = true,
        lsp_format = "fallback",
        range = range,
        formatters = args.fargs[1] and { args.fargs[1] } or nil,
      })
    end, {
      desc = "Format buffer or range",
      range = true,
      nargs = "?",
      complete = function()
        -- Return available formatters for current buffer
        local formatters = conform.list_formatters(0)
        local names = {}
        for _, f in ipairs(formatters) do
          table.insert(names, f.name)
        end
        return names
      end,
    })

    -- Toggle format on save
    local format_on_save_enabled = false
    vim.api.nvim_create_user_command("FormatToggle", function()
      format_on_save_enabled = not format_on_save_enabled
      if format_on_save_enabled then
        vim.notify("Format on save enabled", vim.log.levels.INFO)
      else
        vim.notify("Format on save disabled", vim.log.levels.INFO)
      end
    end, { desc = "Toggle format on save" })

    -- Format on save autocmd (only when enabled)
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("ConformFormatOnSave", { clear = true }),
      callback = function(args)
        if format_on_save_enabled then
          conform.format({ bufnr = args.buf, timeout_ms = 500, lsp_format = "fallback" })
        end
      end,
    })
  end,
}
