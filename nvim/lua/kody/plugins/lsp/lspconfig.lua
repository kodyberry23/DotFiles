return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Diagnostic signs
    local signs = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    }

    -- Diagnostic config
    vim.diagnostic.config({
      signs = {
        text = signs,
      },
      virtual_text = true,
      underline = true,
      update_in_insert = false,
      float = {
        border = "rounded",
        source = true,
      },
    })

    -- LSP handlers with borders
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    )

    -- LSP Keybinds
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

        opts.desc = "Show workspace diagnostics"
        vim.keymap.set("n", "<leader>dw", "<cmd>Telescope diagnostics<CR>", opts)

        -- <leader>dl: Show line diagnostics
        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- Ctrl-k: Signature help (Helix uses Ctrl-k for kill-to-line-end in insert mode)
        -- We prefer LSP signature help as it's more useful in practice
        opts.desc = "Signature help"
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        opts.desc = "Previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>db", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Capabilities
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Global LSP settings (applied to all servers)
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- Configure individual servers
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            enable = true,
            command = "clippy"
          },
        },
      },
    })


    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          },
        },
      },
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config("elixirls", {
      cmd = { "elixir-ls" },
      filetypes = { "elixir", "eelixir", "heex" },
      settings = {
        elixirLS = {
          dialyzerEnabled = false,
          fetchDeps = false,
          enableTestLenses = true,
          suggestSpecs = true,
        },
      },
    })

    vim.lsp.config("tailwindcss", {
      filetypes = {
        "html",
        "css",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
      },
    })

    -- Enable all servers
    vim.lsp.enable({
      "lua_ls",
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "gopls",
      "rust_analyzer",
      "pyright",
      "bashls",
      "jsonls",
      "yamlls",
      "elixirls",
      "erlangls",
      "marksman",
      "jdtls",
    })
  end,
}
