return {
  "folke/tokyonight.nvim",
  lazy = false,    -- MUST be false to load at startup
  priority = 1000, -- Load before all other plugins
  opts = {
    style = "storm",
    transparent = true,
    terminal_colors = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    plugins = {
      auto = true,
    },
    on_highlights = function(hl, c)
      hl.WinSeparator = {
        fg = "#7AA2F7",
        bg = "NONE",
      }
      -- Avante.nvim conflict highlights (must have bg colors for diff visibility)
      -- These are NOT affected by transparent mode - they need visible backgrounds
      hl.AvanteConflictCurrent = { bg = "#562C30", bold = true }       -- Current (ours) - reddish
      hl.AvanteConflictIncoming = { bg = "#314753", bold = true }      -- Incoming (theirs) - bluish
      hl.AvanteConflictCurrentLabel = { bg = "#6b3a3f", bold = true }  -- Label for current
      hl.AvanteConflictIncomingLabel = { bg = "#3d5a6a", bold = true } -- Label for incoming
      -- Ensure DiffAdd/DiffText also have backgrounds (used by other diff tools)
      hl.DiffAdd = { bg = "#2b485a" }    -- Added lines
      hl.DiffText = { bg = "#394b70" }   -- Changed text within a line
      hl.DiffChange = { bg = "#272d43" } -- Changed lines
      hl.DiffDelete = { bg = "#52313f" } -- Deleted lines
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-storm")
    
    -- Set ALL Avante highlights AFTER colorscheme loads
    -- These must be set directly via nvim_set_hl to ensure they have visible bg colors
    -- In agentic mode, Avante uses these highlight groups in replace_in_file.lua:
    --   - AvanteToBeDeletedWOStrikethrough: for lines being deleted (shown as virtual lines above)
    --   - AvanteConflictIncoming: for new/incoming lines being added
    local function set_avante_highlights()
      -- Conflict highlights (used in legacy mode and conflict markers)
      vim.api.nvim_set_hl(0, "AvanteConflictCurrent", { bg = "#562C30", bold = true })
      vim.api.nvim_set_hl(0, "AvanteConflictIncoming", { bg = "#314753", bold = true })
      vim.api.nvim_set_hl(0, "AvanteConflictCurrentLabel", { bg = "#6b3a3f", bold = true })
      vim.api.nvim_set_hl(0, "AvanteConflictIncomingLabel", { bg = "#3d5a6a", bold = true })
      
      -- Agentic mode highlights (used in str_replace/replace_in_file tools)
      -- These are the CRITICAL ones for inline diff visibility in file buffers!
      vim.api.nvim_set_hl(0, "AvanteToBeDeleted", { bg = "#562C30", strikethrough = true })
      vim.api.nvim_set_hl(0, "AvanteToBeDeletedWOStrikethrough", { bg = "#562C30" })
      
      -- Additional Avante UI highlights
      vim.api.nvim_set_hl(0, "AvanteInlineHint", { fg = "#7aa2f7", italic = true })
    end
    
    -- Set immediately
    set_avante_highlights()
    
    -- Also set on ColorScheme event to persist across theme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_avante_highlights,
      desc = "Ensure Avante highlights have visible backgrounds",
    })
  end,
}
