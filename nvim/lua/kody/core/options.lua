local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true
opt.virtualedit = "onemore"

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Floating window borders (Neovim 0.11+)
vim.o.winborder = "rounded"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Swapfiles (disable)
opt.swapfile = false

-- Backspace
opt.backspace = "indent,eol,start"

-- Scrolling
opt.scrolloff = 10 -- Keep 10 lines above/below cursor

-- Update time (faster completion)
opt.updatetime = 50

-- Auto-reload files changed outside of vim
opt.autoread = true

-- Timeout for mapped sequences (default 1000ms is too slow)
opt.timeoutlen = 300 -- Wait 300ms for next key in a mapped sequence
opt.ttimeoutlen = 10 -- Wait 10ms for key codes (faster Esc)

-- Encoding
opt.iskeyword:append("-")

-- ============================================================================
-- SMART AUTO-INDENTATION
-- ============================================================================

-- Auto-indent empty lines to match the previous non-empty line's indentation
-- when entering insert mode. Only works for specific filetypes.
local auto_indent_filetypes = { "python", "elixir", "javascript", "typescript", "lua" }

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    -- Only activate for specified filetypes
    if not vim.tbl_contains(auto_indent_filetypes, vim.bo.filetype) then
      return
    end

    -- Get current line number and content
    local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
    local current_line = vim.api.nvim_get_current_line()

    -- Only process completely empty lines (no content or only whitespace)
    if current_line:match("^%s*$") then
      -- Find the previous non-empty line
      local prev_line_num = current_line_num - 1
      while prev_line_num >= 1 do
        local prev_line = vim.api.nvim_buf_get_lines(0, prev_line_num - 1, prev_line_num, false)[1]
        if prev_line and not prev_line:match("^%s*$") then
          -- Extract indentation from the previous non-empty line
          local indentation = prev_line:match("^(%s*)")
          if indentation then
            -- Set current line to have the same indentation
            vim.api.nvim_set_current_line(indentation)
            -- Position cursor at the end of the indentation
            vim.api.nvim_win_set_cursor(0, { current_line_num, #indentation })
          end
          break
        end
        prev_line_num = prev_line_num - 1
      end
    end
  end,
  desc = "Auto-indent empty lines to match previous non-empty line",
})

opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver50-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20"