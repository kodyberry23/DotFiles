return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = "󰠠 ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
      virtual_text = {
        current_line = true,
        format = function(d)
          return #d.message > 60 and d.message:sub(1, 57) .. "..." or d.message
        end,
      },
      underline = true,
      update_in_insert = false,
      float = { border = "rounded", source = true, max_width = 80 },
    })

    vim.o.winborder = "rounded"

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end
        local function jump(count)
          return function() vim.diagnostic.jump({ count = count, float = true }) end
        end
        map("n", "gr", "<cmd>Telescope lsp_references<CR>",       "Show LSP references")
        map("n", "gD", vim.lsp.buf.declaration,                   "Go to declaration")
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>",      "Show LSP definitions")
        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>",  "Show LSP implementations")
        map("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
        map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action,   "Code action")
        map("n", "<leader>r",  vim.lsp.buf.rename,                "Smart rename")
        map("n", "<leader>dl", vim.diagnostic.open_float,         "Show line diagnostics")
        map("n", "<leader>db", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
        map("n", "K",    function() vim.lsp.buf.hover({ max_width = 100, max_height = 30 }) end, "Hover documentation")
        map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "[d", jump(-1), "Previous diagnostic")
        map("n", "]d", jump(1),  "Next diagnostic")
        map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
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
      -- rust-analyzer is tuned for memory: defaults analyze all feature gates
      -- and keep 128 syntax trees around, which adds up on large workspaces.
      settings = {
        ["rust-analyzer"] = {
          cachePriming = { enable = false }, -- RA maintainer recommendation
          cargo = {
            allFeatures = false, -- scanning every feature is a memory hog
            loadOutDirsFromCheck = true,
            buildScripts = { enable = true },
          },
          checkOnSave = {
            enable = true,
            command = "check", -- clippy uses an order of magnitude more resources
          },
          diagnostics = { enable = true, disabled = { "inactive-code", "unlinked-file" } },
          procMacro = { enable = true, attributes = { enable = true } },
          files = {
            exclude = { ".direnv", ".git", ".github", ".gitlab", "bin", "node_modules", "target", "venv", ".venv" },
            watcher = "client", -- let neovim handle file watching, not RA
          },
          imports = {
            granularity = { group = "module", enforce = true },
            prefix = "crate",
          },
          inlayHints = {
            bindingModeHints = { enable = true },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true, minLines = 10 },
            closureReturnTypeHints = { enable = "with_block" },
            lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = true },
            parameterHints = { enable = true },
            typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            maxLength = 25,
          },
          lens = { enable = false }, -- expensive, purely visual
          lru = { capacity = 64 },   -- half the default 128 syntax trees
          hover = {
            actions = { enable = true, references = { enable = true } },
            documentation = { enable = true },
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
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
              "docker-compose.yml",
              "docker-compose.yaml",
              "docker-compose.*.yml",
              "docker-compose.*.yaml",
              "compose.yml",
              "compose.yaml",
              "*docker*.yml",
              "*docker*.yaml",
            },
            ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
            ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
            ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = {
              "playbook.yml",
              "playbook.yaml",
              "site.yml",
              "site.yaml",
            },
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
              ".gitlab-ci.yml",
              ".gitlab-ci.yaml",
              ".gitlab/*.yml",
              ".gitlab/*.yaml",
              ".gitlab/**/*.yml",
              ".gitlab/**/*.yaml",
              "ci/*.yml",
              "ci/*.yaml",
              "ci/**/*.yml",
              "ci/**/*.yaml",
              "templates/*.yml",
              "templates/*.yaml",
              "templates/**/*.yml",
              "templates/**/*.yaml",
            },
          },
          schemaStore = {
            enable = false,
          },
          validate = true,
          format = { enable = true },
          hover = true,
          completion = true,
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

    -- elixir-ls launcher installed by scripts/install-elixir-ls.sh detects
    -- asdf/mise/vfox internally — do NOT wrap in `mise x` or `asdf exec`.
    local elixirls_launcher = vim.fn.expand("~/.local/share/elixir-ls/language_server.sh")
    vim.lsp.config("elixirls", {
      cmd = { elixirls_launcher },
      filetypes = { "elixir", "eelixir", "heex", "surface" },
      settings = {
        elixirLS = {
          mixEnv = vim.env.MIX_ENV,
          mixTarget = vim.env.MIX_TARGET,
          dialyzerEnabled = false,
          fetchDeps = false,
          enableTestLenses = true,
          suggestSpecs = true,
        },
      },
    })

    local mason_erlangls = vim.fn.stdpath("data") .. "/mason/bin/erlang_ls"
    local erlangls_cmd = (vim.fn.executable(mason_erlangls) == 1 and mason_erlangls)
      or (vim.fn.executable("erlang_ls") == 1 and "erlang_ls" or nil)
    if erlangls_cmd then
      vim.lsp.config("erlangls", { cmd = { erlangls_cmd }, filetypes = { "erlang" } })
    end

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

    -- Only load Angular plugin when angular.json exists in project
    local angular_plugins = {}
    if vim.fn.findfile("angular.json", ".;") ~= "" then
      angular_plugins = {
        {
          name = "@angular/language-server",
          location = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules/@angular/language-server",
          enableForWorkspaceTypeScriptVersions = false,
        },
      }
    end

    local ts_inlay_hints = {
      parameterNames         = { enabled = "literals" },
      parameterTypes         = { enabled = true },
      variableTypes          = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      functionLikeReturnTypes  = { enabled = true },
      enumMemberValues       = { enabled = true },
    }
    -- includePackageJsonAutoImports="off" avoids scanning every package.json
    -- export — expensive in monorepos and rarely useful.
    local ts_js_prefs = {
      includePackageJsonAutoImports = "off",
      quotePreference               = "auto",
      jsxAttributeCompletionStyle   = "auto",
    }

    vim.lsp.config("vtsls", {
      filetypes = {
        "javascript", "javascriptreact", "javascript.jsx",
        "typescript", "typescriptreact", "typescript.tsx",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = { enableServerSideFuzzyMatch = true },
          },
          tsserver = { globalPlugins = angular_plugins },
        },
        typescript = {
          tsserver = { maxTsServerMemory = 4096 },
          updateImportsOnFileMove = { enabled = "always" },
          suggest = { completeFunctionCalls = true },
          inlayHints = ts_inlay_hints,
          preferences = vim.tbl_extend("force", ts_js_prefs, {
            includeCompletionsForModuleExports = true,
            includeCompletionsWithSnippetText  = true,
            includeCompletionsWithInsertText   = true,
            importModuleSpecifierPreference    = "non-relative",
          }),
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = { completeFunctionCalls = true },
          inlayHints = ts_inlay_hints,
          preferences = ts_js_prefs,
        },
      },
    })

    vim.lsp.enable({
      "lua_ls", "vtsls", "rust_analyzer", "elixirls", "erlangls",
      "bashls", "jsonls", "yamlls", "jdtls", "marksman",
    })

    -- Conditional servers (only enable when project markers exist)
    local conditional_servers = {
      { servers = { "angularls" }, markers = { "angular.json" } },
      { servers = { "gopls" }, markers = { "go.mod", "go.sum" } },
      { servers = { "pyright" }, markers = { "pyproject.toml", "setup.py", "requirements.txt", "pyrightconfig.json" } },
      { servers = { "html", "cssls" }, markers = { "package.json" } },
      { servers = { "tailwindcss" }, markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.mjs", "tailwind.config.cjs" } },
    }

    for _, entry in ipairs(conditional_servers) do
      for _, marker in ipairs(entry.markers) do
        if vim.fn.findfile(marker, ".;") ~= "" then
          vim.lsp.enable(entry.servers)
          break
        end
      end
    end
  end,
}
