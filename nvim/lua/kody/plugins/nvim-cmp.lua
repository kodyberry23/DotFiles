return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "windwp/nvim-autopairs", -- Fixed: Added missing dependency
  },
  opts = function()
    local cmp = require("cmp")
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    return {
      enabled = function()
        local context = require("cmp.config.context")
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        end
        return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
      end,
      completion = { completeopt = "menu,menuone,noinsert" },
      preselect = cmp.PreselectMode.Item,
      mapping = cmp.mapping.preset.insert({
        -- Scrolling
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        
        -- Navigation
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        
        -- Completion
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        
        -- Note: These may not work in all terminals due to key code limitations
        ["<S-CR>"] = cmp.mapping.confirm({ 
          behavior = cmp.ConfirmBehavior.Replace, 
          select = true 
        }),
        ["<C-CR>"] = cmp.mapping(function(fallback)
          cmp.abort()
          fallback()
        end),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(entry, item)
          item.menu = entry.source.name
          return item
        end,
      },
      experimental = {
        ghost_text = false,
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)

    -- Command-line completion for `:` commands
    cmp.setup.cmdline(":", {
      completion = { completeopt = "menu,menuone,noselect" },
      mapping = cmp.mapping.preset.cmdline({
        ["<Tab>"] = { c = cmp.mapping.select_next_item() },
        ["<S-Tab>"] = { c = cmp.mapping.select_prev_item() },
        ["<C-n>"] = { c = cmp.mapping.select_next_item() },
        ["<C-e>"] = { c = cmp.mapping.abort() },
        -- No <CR> mapping - Enter executes your command, use Tab to select completions
      }),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    -- Command-line completion for `/` and `?` search
    cmp.setup.cmdline({ "/", "?" }, {
      completion = { completeopt = "menu,menuone,noselect" },
      mapping = cmp.mapping.preset.cmdline({
        ["<Tab>"] = { c = cmp.mapping.select_next_item() },
        ["<S-Tab>"] = { c = cmp.mapping.select_prev_item() },
        ["<C-n>"] = { c = cmp.mapping.select_next_item() },
        ["<C-e>"] = { c = cmp.mapping.abort() },
        -- No <CR> mapping - Enter executes your search, use Tab to select completions
      }),
      sources = {
        { name = "buffer" },
      },
    })

    -- Autopairs integration
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
