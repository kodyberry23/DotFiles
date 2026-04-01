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
      virtual_text = {
        -- Only show virtual text on the current cursor line
        current_line = true,
        format = function(diagnostic)
          -- Truncate long messages for inline display
          local message = diagnostic.message
          if #message > 60 then
            return message:sub(1, 57) .. "..."
          end
          return message
        end,
      },
      underline = true,
      update_in_insert = false,
      float = {
        border = "rounded",
        source = true,
        max_width = 80,
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

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

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
          cachePriming = {
            enable = false, -- Don't eagerly warm caches on startup (RA maintainer recommendation)
          },
          cargo = {
            allFeatures = false, -- Was true; analyzing all feature gates is a major memory hog
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = {
            enable = true,
            command = "check", -- Was "clippy"; clippy uses an order of magnitude more resources
            extraArgs = { "--no-deps" }, -- Only check current package, not entire workspace
          },
          diagnostics = {
            enable = true,
            disabled = { "inactive-code", "unlinked-file" },
          },
          procMacro = {
            enable = true,
            attributes = {
              enable = true,
            },
          },
          files = {
            exclude = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
            watcher = "client", -- Was "server"; let neovim handle file watching
          },
          imports = {
            granularity = {
              group = "module",
              enforce = true,
            },
            prefix = "crate",
          },
          inlayHints = {
            bindingModeHints = {
              enable = true,
            },
            chainingHints = {
              enable = true,
            },
            closingBraceHints = {
              enable = true,
              minLines = 10,
            },
            closureReturnTypeHints = {
              enable = "with_block",
            },
            lifetimeElisionHints = {
              enable = "skip_trivial",
              useParameterNames = true,
            },
            parameterHints = {
              enable = true,
            },
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedConstructor = false,
            },
            maxLength = 25,
          },
          lens = {
            enable = false, -- Was true; code lens is expensive and purely visual
          },
          lru = {
            capacity = 64, -- Reduce from default 128 syntax trees kept in memory
          },
          hover = {
            actions = {
              enable = true,
              references = {
                enable = true,
              },
            },
            documentation = {
              enable = true,
            },
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

    local mason_elixirls = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls"
    vim.lsp.config("elixirls", {
      cmd = vim.fn.executable(mason_elixirls) == 1 and { mason_elixirls } or { "elixir-ls" },
      filetypes = { "elixir", "eelixir", "heex" },
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
    local erlangls_cmd = vim.fn.executable(mason_erlangls) == 1 and mason_erlangls
      or (vim.fn.executable("erlang_ls") == 1 and "erlang_ls" or "erlangls")
    vim.lsp.config("erlangls", {
      cmd = { erlangls_cmd },
      filetypes = { "erlang" },
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

    vim.lsp.config("vtsls", {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      settings = {
        complete_function_calls = true,
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
          tsserver = {
            globalPlugins = angular_plugins,
          },
        },
        typescript = {
          tsserver = {
            maxTsServerMemory = 4096,
          },
          updateImportsOnFileMove = { enabled = "always" },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
          preferences = {
            includeCompletionsForModuleExports = true,
            includeCompletionsWithSnippetText = true,
            includeCompletionsWithInsertText = true,
            importModuleSpecifierPreference = "non-relative",
            includePackageJsonAutoImports = "off", -- Was "on"; scanning all package.json exports is expensive
            quotePreference = "auto",
            jsxAttributeCompletionStyle = "auto",
          },
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            enumMemberValues = { enabled = true },
          },
          preferences = {
            includePackageJsonAutoImports = "off", -- Was "on"
            quotePreference = "auto",
            jsxAttributeCompletionStyle = "auto",
          },
        },
      },
    })

    -- Always-on servers (start when matching filetype opens)
    vim.lsp.enable({
      "lua_ls",
      "vtsls",
      "rust_analyzer",
      "elixirls",
      "erlangls",
      "bashls",
      "jsonls",
      "yamlls",
      "jdtls",
      "marksman",
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
