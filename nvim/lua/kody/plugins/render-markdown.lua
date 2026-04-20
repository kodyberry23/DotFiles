-- In-buffer markdown rendering. Config combines community best practices
-- (LazyVim defaults, linkarzu's neobean, plugin author's own config) with
-- cyberdream-tinted highlights.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons", -- code-block language icons
  },
  ft = { "markdown", "Avante", "codecompanion", "copilot-chat" },
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  opts = {
    file_types = { "markdown", "Avante", "codecompanion", "copilot-chat" },
    completions = { lsp = { enabled = true } }, -- nvim-cmp picks up callout/checkbox chars
    -- Reveal raw syntax on the cursor line, but don't flicker these — otherwise
    -- code bg / indent guides / signs strobe on cursor move.
    anti_conceal = {
      enabled = true,
      ignore = {
        code_background = true,
        indent          = true,
        sign            = true,
        virtual_lines   = true,
      },
    },
    heading = {
      sign = false, -- keep signcolumn clean for diagnostics/git
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }, -- numbered-circle nerd-font glyphs
      width = "full", -- full-line background bar
      left_pad = 1,
      right_pad = 0,
      border = false,
    },
    code = {
      style = "full",   -- language icon + name above the block
      width = "full",
      left_pad = 2,
      right_pad = 2,
      min_width = 45,   -- avoids awkward skinny blocks
      border = "thick",
      language_pad = 2,
      sign = false,
    },
    bullet = {
      icons = { "●", "○", "◆", "◇" },
      right_pad = 1,
    },
    checkbox = {
      position = "inline",
      unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
      checked   = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
      },
    },
    pipe_table = {
      preset = "round",
      alignment_indicator = "┅",
    },
    html = {
      enabled = true,
      comment = { conceal = false }, -- never hide HTML comments (easy to orphan otherwise)
    },
    -- Render markdown inside floating nofile buffers (AI chat windows).
    overrides = {
      buftype = {
        nofile = {
          render_modes = true,
          padding = { highlight = "NormalFloat" },
          sign = { enabled = false },
        },
      },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Cyberdream palette (matches zellij/config.kdl + colorscheme).
    local p = {
      coral  = "#FF6E5E",
      orange = "#FFBD5E",
      yellow = "#F1FF5E",
      cyan   = "#5EF1FF",
      blue   = "#5EA1FF",
      purple = "#BD5EFF",
      white  = "#FFFFFF",
      dim    = "#7B8496",
      bg     = "#1E2124", -- slightly lighter than Normal for code blocks
      border = "#3C4048",
    }

    local groups = {
      -- Full-width heading bars, saturated-dark bg per accent.
      RenderMarkdownH1 = { fg = p.coral,  bg = "#5C2A22", bold = true },
      RenderMarkdownH2 = { fg = p.orange, bg = "#5C4722", bold = true },
      RenderMarkdownH3 = { fg = p.cyan,   bg = "#205A62", bold = true },
      RenderMarkdownH4 = { fg = p.blue,   bg = "#223E5A", bold = true },
      RenderMarkdownH5 = { fg = p.purple, bg = "#4A225C", bold = true },
      RenderMarkdownH6 = { fg = p.dim,    bg = "#30343C", bold = true },
      RenderMarkdownH1Bg = { bg = "#5C2A22" },
      RenderMarkdownH2Bg = { bg = "#5C4722" },
      RenderMarkdownH3Bg = { bg = "#205A62" },
      RenderMarkdownH4Bg = { bg = "#223E5A" },
      RenderMarkdownH5Bg = { bg = "#4A225C" },
      RenderMarkdownH6Bg = { bg = "#30343C" },
      -- Code blocks
      RenderMarkdownCode         = { bg = p.bg },
      RenderMarkdownCodeInline   = { fg = p.orange, bg = p.bg },
      RenderMarkdownCodeBorder   = { fg = p.border, bg = p.bg },
      RenderMarkdownCodeFallback = { bg = p.bg },
      RenderMarkdownCodeInfo     = { fg = p.blue,   bg = p.bg },
      -- Quotes cycle per nesting depth
      RenderMarkdownQuote1 = { fg = p.blue },
      RenderMarkdownQuote2 = { fg = p.cyan },
      RenderMarkdownQuote3 = { fg = p.purple },
      RenderMarkdownQuote4 = { fg = p.coral },
      RenderMarkdownQuote5 = { fg = p.orange },
      RenderMarkdownQuote6 = { fg = p.white },
      -- Bullets / dashes
      RenderMarkdownBullet = { fg = p.blue },
      RenderMarkdownDash   = { fg = p.border },
      -- Checkboxes
      RenderMarkdownUnchecked = { fg = p.dim },
      RenderMarkdownChecked   = { fg = p.cyan },
      RenderMarkdownTodo      = { fg = p.orange },
      -- Links
      RenderMarkdownLink      = { fg = p.cyan, underline = true },
      RenderMarkdownLinkTitle = { fg = p.blue },
      RenderMarkdownWikiLink  = { fg = p.cyan, underline = true },
      -- Callouts ([!NOTE], [!WARNING], etc.)
      RenderMarkdownInfo    = { fg = p.blue },
      RenderMarkdownSuccess = { fg = p.cyan },
      RenderMarkdownHint    = { fg = p.purple },
      RenderMarkdownWarn    = { fg = p.orange },
      RenderMarkdownError   = { fg = p.coral },
      -- Tables
      RenderMarkdownTableHead = { fg = p.blue, bold = true },
      RenderMarkdownTableRow  = { fg = p.white },
    }

    local function apply()
      for group, spec in pairs(groups) do
        vim.api.nvim_set_hl(0, group, spec)
      end
    end
    apply()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("RenderMarkdownCyberdream", { clear = true }),
      callback = apply,
    })
  end,
}
