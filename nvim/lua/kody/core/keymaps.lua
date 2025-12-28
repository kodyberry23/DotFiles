local keymap = vim.keymap

-- Leader keys are set in lazy.lua before plugins load

-- ============================================================================
-- HELIX-STYLE KEYMAPS
-- https://docs.helix-editor.com/keymap.html
-- ============================================================================

-- Clear search highlights (helix: Escape clears)
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- ============================================================================
-- SPACE MODE (Leader) - Pickers and actions
-- ============================================================================

-- File/buffer pickers (telescope handles these in telescope.lua)
-- <leader>f - file picker
-- <leader>F - file picker (hidden)
-- <leader>b - buffer picker
-- <leader>j - jumplist picker
-- <leader>g - changed files (git status)
-- <leader>s - document symbols
-- <leader>S - workspace symbols
-- <leader>d - document diagnostics
-- <leader>D - workspace diagnostics
-- <leader>/ - global search
-- <leader>? - command palette

-- LSP actions (defined in lsp.lua via LspAttach)
-- <leader>r - rename symbol
-- <leader>a - code action
-- <leader>k - hover (using K instead, more vim-like)

-- Comments (helix: space+c)
keymap.set("n", "<leader>c", "gcc", { remap = true, desc = "Toggle comment" })
keymap.set("v", "<leader>c", "gc", { remap = true, desc = "Toggle comment" })

-- Clipboard (helix: space+y/p for system clipboard)
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from clipboard" })

-- File explorer keymaps are defined in nvim-tree.lua plugin config

-- ============================================================================
-- WINDOW MODE (Ctrl-w or space+w)
-- ============================================================================

-- Window navigation (Ctrl-w + hjkl, or just Ctrl-hjkl)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Window splits (helix: Ctrl-w + s/v)
keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
keymap.set("n", "<leader>ws", "<cmd>split<CR>", { desc = "Horizontal split" })
keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close window" })
keymap.set("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close others" })
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Cycle window" })
keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize" })

-- Window swapping (helix: Ctrl-w + HJKL)
keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move window down" })
keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })
keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })

-- ============================================================================
-- GOTO MODE (g prefix) - Navigation
-- ============================================================================

-- Go to file start/end (helix: gg/ge)
keymap.set("n", "ge", "G", { desc = "Go to last line" })
keymap.set("n", "gh", "^", { desc = "Go to line start" })
keymap.set("n", "gl", "$", { desc = "Go to line end" })
keymap.set("n", "gs", "^", { desc = "Go to first non-blank" })

-- Buffer navigation (helix: gn/gp)
keymap.set("n", "gn", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "gp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Additional goto mode (helix style)
keymap.set("n", "ga", "<C-^>", { desc = "Last accessed file" })
keymap.set("n", "gt", "H", { desc = "Go to window top" })
keymap.set("n", "gm", "M", { desc = "Go to window middle" })
keymap.set("n", "gb", "L", { desc = "Go to window bottom" })
keymap.set("n", "g.", "`.", { desc = "Go to last modification" })

-- Visual and operator-pending modes: use as motion
-- This allows natural Vim behavior: vgl, dgl, cgl, etc.
keymap.set({ "x", "o" }, "ge", "G", { desc = "To last line" })
keymap.set({ "x", "o" }, "gh", "0", { desc = "To line start" })
keymap.set({ "x", "o" }, "gl", "$", { desc = "To line end" })
keymap.set({ "x", "o" }, "gs", "^", { desc = "To first non-blank" })
keymap.set({ "x", "o" }, "gt", "H", { desc = "To window top" })
keymap.set({ "x", "o" }, "gm", "M", { desc = "To window middle" })
keymap.set({ "x", "o" }, "gb", "L", { desc = "To window bottom" })

-- LSP goto (defined in lsp.lua)
-- gd - go to definition
-- gy - go to type definition
-- gr - go to references
-- gi - go to implementation
-- gD - go to declaration

-- ============================================================================
-- UNIMPAIRED (]/[ prefix) - Next/prev navigation
-- ============================================================================

-- Diagnostics (helix: ]d/[d for next/prev, ]D/[D for last/first)
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
keymap.set("n", "]D", function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics > 0 then
    vim.diagnostic.goto_next({ count = #diagnostics, wrap = false })
  end
end, { desc = "Last diagnostic in document" })
keymap.set("n", "[D", function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics > 0 then
    vim.diagnostic.goto_prev({ count = #diagnostics, wrap = false })
  end
end, { desc = "First diagnostic in document" })

-- Buffers
keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

-- Quickfix
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Prev quickfix" })

-- Add blank lines (helix: ]space/[space)
keymap.set("n", "]<Space>", "o<Esc>", { desc = "Add line below" })
keymap.set("n", "[<Space>", "O<Esc>", { desc = "Add line above" })

-- Git hunks handled in gitsigns.lua (]g/[g)

-- Paragraph navigation (helix: ]p/[p)
keymap.set("n", "]p", "}", { desc = "Next paragraph" })
keymap.set("n", "[p", "{", { desc = "Prev paragraph" })

-- ============================================================================
-- MATCH MODE (m prefix) - Brackets and surround
-- ============================================================================

-- Match brackets (helix: mm)
keymap.set("n", "mm", "%", { desc = "Match brackets" })
keymap.set("v", "mm", "%", { desc = "Match brackets" })

-- Surround operations (helix: ms/mr/md)
-- Handled by mini.surround plugin in mini-surround.lua

-- Text objects in match mode (helix: ma/mi for around/inner)
-- These work with the built-in text objects
keymap.set({ "o", "x" }, "ma", "a", { desc = "Around textobject" })
keymap.set({ "o", "x" }, "mi", "i", { desc = "Inner textobject" })

-- ============================================================================
-- SELECTION / EDITING
-- ============================================================================

-- Extend line (helix: x selects line, X extends to line bounds)
keymap.set("n", "x", "V", { desc = "Select line" })
keymap.set("v", "x", function()
  -- In visual mode, extend by full lines
  vim.cmd("normal! j")
  -- Ensure we're in linewise visual mode
  if vim.fn.mode() ~= "V" then
    vim.cmd("normal! V")
  end
end, { desc = "Extend line down" })
keymap.set("n", "X", "V$", { desc = "Select to line end" })
keymap.set("v", "X", "$", { desc = "Extend to line end" })

-- Select all (helix: %)
keymap.set("n", "%", "ggVG", { desc = "Select all" })

-- NOTE: ; and , are used for repeating motions (treesitter-textobjects)
-- Helix uses ; to collapse and , to keep selection, but repeat is more useful in vim
-- Use <Esc> to collapse selection instead
-- Alt-. also repeats last motion for Helix compatibility
keymap.set({ "n", "x", "o" }, "<A-.>", ";", { remap = true, desc = "Repeat last motion" })

-- Copy selection to next/prev line (helix: C/Alt-C)
-- Note: True multi-cursor requires a plugin, this is a simple version
keymap.set("n", "C", "yyp", { desc = "Copy line down" })
keymap.set("v", "C", "yPgv", { desc = "Copy selection" })
keymap.set("n", "<A-C>", "yyP", { desc = "Copy line up" })

-- Better indenting (stay in visual mode)
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines (using Ctrl-Shift to avoid conflict with zellij nav)
keymap.set("n", "<C-S-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<C-S-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
keymap.set("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Join lines (helix: J, keep cursor position)
keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- Paste over selection without yanking (helix-style)
keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })

-- Delete/Change in Helix style: operate on selections without yanking
-- In Helix, d/c work on the current selection and don't pollute registers
keymap.set("v", "d", '"_d', { desc = "Delete selection (no yank)" })
keymap.set("v", "c", '"_c', { desc = "Change selection (no yank)" })

-- Keep Alt-d/Alt-c as explicit "delete without yank" in normal mode
keymap.set("n", "<A-d>", '"_d', { desc = "Delete (no yank)" })
keymap.set("n", "<A-c>", '"_c', { desc = "Change (no yank)" })

-- Replace with character (helix: r)
-- In visual mode, replace all selected characters with a single character
keymap.set("v", "r", function()
  vim.cmd('normal! "_c')
  local char = vim.fn.getcharstr()
  if char:match("%w") or char:match("%p") or char == " " then
    local count = vim.fn.col("'>") - vim.fn.col("'<") + 1
    vim.api.nvim_put({string.rep(char, count)}, "c", true, true)
  end
  vim.cmd("stopinsert")
end, { desc = "Replace selection with char" })

-- Replace with yanked text (helix: R)
-- Delete selection to black hole and paste from yank register
keymap.set("v", "R", '"_d"0P', { desc = "Replace with yanked" })
keymap.set("n", "R", function()
  -- In normal mode, replace character under cursor with yanked text
  vim.cmd('normal! "_cl')
  vim.cmd('normal! "0P')
end, { desc = "Replace char with yanked" })

-- Case switching (helix: ~ toggle, ` lowercase, Alt-` uppercase)
-- Helix behavior: operates on selection in visual mode, single char in normal mode
keymap.set("n", "`", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! vu")
  vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Lowercase char" })
keymap.set("v", "`", "u", { desc = "Lowercase selection" })
keymap.set("n", "<A-`>", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! vU")
  vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Uppercase char" })
keymap.set("v", "<A-`>", "U", { desc = "Uppercase selection" })
-- ~ already works as switch_case in vim by default

-- Undo/Redo (helix: u/U)
keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Macros (helix: Q record, q replay) - swapped from vim default
keymap.set("n", "Q", "q", { desc = "Record macro" })
keymap.set("n", "q", "@q", { desc = "Replay macro" })

-- Increment/Decrement (helix: Ctrl-a/Ctrl-x) - already vim default
-- Just documenting they exist

-- ============================================================================
-- VIEW MODE (z prefix) - Scrolling
-- ============================================================================

-- Helix view mode uses zc/zt/zb/zm for center/top/bottom/middle
keymap.set("n", "zc", "zz", { desc = "Center cursor" })
keymap.set("n", "zz", "zz", { desc = "Center cursor" })
keymap.set("n", "zt", "zt", { desc = "Cursor to top" })
keymap.set("n", "zb", "zb", { desc = "Cursor to bottom" })
keymap.set("n", "zm", "zz", { desc = "Center cursor (middle)" })

-- Scroll view (helix: zj/zk)
keymap.set("n", "zj", "<C-e>", { desc = "Scroll down" })
keymap.set("n", "zk", "<C-y>", { desc = "Scroll up" })

-- Half-page scroll (centered)
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Keep centered when searching
keymap.set("n", "n", "nzzzv", { desc = "Next match" })
keymap.set("n", "N", "Nzzzv", { desc = "Prev match" })

-- ============================================================================
-- MISC
-- ============================================================================

-- Quick save (helix uses :w, but Ctrl-s is convenient)
keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save" })

-- Quit
keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
keymap.set("n", "<leader>qw", "<cmd>wqa<CR>", { desc = "Save and quit all" })
keymap.set("n", "<leader>qQ", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- Buffer delete
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force delete buffer" })

-- Toggle options (custom, not helix)
keymap.set("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
keymap.set("n", "<leader>un", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative number" })
keymap.set("n", "<leader>us", "<cmd>set spell!<CR>", { desc = "Toggle spell" })
keymap.set("n", "<leader>ul", "<cmd>set list!<CR>", { desc = "Toggle listchars" })

-- ============================================================================
-- ADDITIONAL SPACE MODE (helix style)
-- ============================================================================

-- Hover (helix: space+k) - K works in normal mode, this is alternative
keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover docs" })

-- Last picker (helix: space+') - resume telescope
keymap.set("n", "<leader>'", "<cmd>Telescope resume<CR>", { desc = "Last picker" })

-- Block comment toggle (helix: space+C)
keymap.set("n", "<leader>C", "gbc", { remap = true, desc = "Toggle block comment" })
keymap.set("v", "<leader>C", "gb", { remap = true, desc = "Toggle block comment" })

-- Replace from clipboard (helix: space+R)
keymap.set("n", "<leader>R", '"+P', { desc = "Replace from clipboard" })
keymap.set("v", "<leader>R", '"+p', { desc = "Replace from clipboard" })

-- ============================================================================
-- INSERT MODE (helix style)
-- ============================================================================

-- Delete word backward (helix: Ctrl-w or Alt-Backspace)
keymap.set("i", "<C-w>", "<C-w>", { desc = "Delete word backward" })
keymap.set("i", "<A-BS>", "<C-w>", { desc = "Delete word backward" })

-- Delete word forward (helix: Alt-d)
keymap.set("i", "<A-d>", "<C-o>dw", { desc = "Delete word forward" })

-- Kill to line start (helix: Ctrl-u)
keymap.set("i", "<C-u>", "<C-u>", { desc = "Kill to line start" })

-- Kill to line end (helix: Ctrl-k)
keymap.set("i", "<C-k>", "<C-o>D", { desc = "Kill to line end" })

-- ============================================================================
-- SHELL COMMANDS (helix style)
-- ============================================================================

-- Shell pipe (helix: |)
keymap.set("v", "|", ":!", { desc = "Shell pipe" })

-- Shell insert output (helix: !)
keymap.set("n", "!", ":r!", { desc = "Insert shell output" })
