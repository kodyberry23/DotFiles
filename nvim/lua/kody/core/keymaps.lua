local keymap = vim.keymap

-- Leader keys are set in lazy.lua before plugins load

-- ============================================================================
-- HELIX-STYLE KEYMAPS
-- Reference: https://docs.helix-editor.com/keymap.html
-- ============================================================================

-- NOTE: Multi-cursor/selection features (s, S, Alt-s, &, _, etc.) are handled
-- by vim-visual-multi plugin. Start with <C-n> on a word, then use Helix keys.
-- See: nvim/lua/kody/plugins/vim-visual-multi.lua

-- ============================================================================
-- GENERAL
-- ============================================================================

-- Clear search highlights (helix: Escape clears)
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- Quick save (helix uses :w, but Ctrl-s is convenient)
keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save file" })

-- ============================================================================
-- SPACE MODE (Leader) - Pickers and Actions
-- ============================================================================

-- File/buffer pickers (telescope handles these in telescope.lua)
-- <leader>f - file picker
-- <leader>F - file picker (hidden)
-- <leader>b - buffer picker
-- <leader>j - jumplist picker
-- <leader>g - changed files (git status)
-- <leader>s - document symbols
-- <leader>S - workspace symbols
-- <leader>xb - buffer diagnostics
-- <leader>xw - workspace diagnostics
-- <leader>xl - line diagnostics
-- <leader>/ - global search
-- <leader>? - command palette

-- LSP actions (defined in lsp.lua via LspAttach)
-- <leader>r - rename symbol
-- <leader>a - code action
-- <leader>k - hover docs

-- Comments: handled by Comment.nvim (gcc = line, gbc = block toggle, gc/gb = operators)

-- Clipboard operations (helix: space+y/p for system clipboard)
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from clipboard" })
keymap.set("n", "<leader>R", '"+P', { desc = "Replace from clipboard" })
keymap.set("v", "<leader>R", '"+p', { desc = "Replace from clipboard" })

-- Telescope picker (helix: space+')
keymap.set("n", "<leader>'", "<cmd>Telescope resume<CR>", { desc = "Resume last picker" })

-- Hover documentation (helix: space+k)
keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover docs" })

-- Quit commands
keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
keymap.set("n", "<leader>qw", "<cmd>wqa<CR>", { desc = "Save and quit all" })
keymap.set("n", "<leader>qQ", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- Toggle options
keymap.set("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
keymap.set("n", "<leader>un", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative number" })
keymap.set("n", "<leader>us", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })
keymap.set("n", "<leader>ul", "<cmd>set list!<CR>", { desc = "Toggle listchars" })

-- File explorer keymaps are defined in nvim-tree.lua plugin config

-- ============================================================================
-- WINDOW MODE (Ctrl-w or space+w)
-- ============================================================================

-- Window navigation (Ctrl-hjkl)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window splits (helix: Ctrl-w + s/v)
keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
keymap.set("n", "<leader>ws", "<cmd>split<CR>", { desc = "Horizontal split" })
keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close window" })
keymap.set("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close other windows" })
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Cycle to next window" })
keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })

-- Window movement (helix: Ctrl-w + HJKL)
keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move window down" })
keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })
keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })

-- ============================================================================
-- GOTO MODE (g prefix) - Navigation
-- ============================================================================

-- File navigation (helix: gg/ge/gh/gl/gs)
keymap.set("n", "ge", "G", { desc = "Go to last line" })
keymap.set("n", "gh", "^", { desc = "Go to line start" })
keymap.set("n", "gl", "$", { desc = "Go to line end" })
keymap.set("n", "gs", "^", { desc = "Go to first non-blank" })

-- Buffer navigation (helix: gn/gp)
keymap.set("n", "gn", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "gp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Additional goto commands
keymap.set("n", "ga", "<C-^>", { desc = "Go to alternate file" })
keymap.set("n", "gt", "H", { desc = "Go to window top" })
keymap.set("n", "gm", "M", { desc = "Go to window middle" })
-- gb removed - now used for block comments in Comment.nvim
keymap.set("n", "g.", "`.", { desc = "Go to last change" })

-- Visual and operator-pending mode motions
-- Allows natural Vim behavior: vgl, dgl, cgl, etc.
keymap.set({ "x", "o" }, "ge", "G", { desc = "To last line" })
keymap.set({ "x", "o" }, "gh", "0", { desc = "To line start" })
keymap.set({ "x", "o" }, "gl", "$", { desc = "To line end" })
keymap.set({ "x", "o" }, "gs", "^", { desc = "To first non-blank" })
keymap.set({ "x", "o" }, "gt", "H", { desc = "To window top" })
keymap.set({ "x", "o" }, "gm", "M", { desc = "To window middle" })
-- gb removed - now used for block comments in Comment.nvim

-- LSP goto commands (defined in lsp.lua)
-- gd - go to definition
-- gy - go to type definition
-- gr - go to references
-- gi - go to implementation
-- gD - go to declaration

-- ============================================================================
-- UNIMPAIRED (]/[ prefix) - Next/Previous Navigation
-- ============================================================================

-- Diagnostics (helix: ]d/[d for next/prev, ]D/[D for last/first)
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap.set("n", "]D", function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics > 0 then
    vim.diagnostic.goto_next({ count = #diagnostics, wrap = false })
  end
end, { desc = "Last diagnostic" })
keymap.set("n", "[D", function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics > 0 then
    vim.diagnostic.goto_prev({ count = #diagnostics, wrap = false })
  end
end, { desc = "First diagnostic" })

-- Buffer navigation
keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Quickfix navigation
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- Paragraph navigation (helix: ]p/[p)
keymap.set("n", "]p", "}", { desc = "Next paragraph" })
keymap.set("n", "[p", "{", { desc = "Previous paragraph" })

-- Add blank lines (helix: ]space/[space)
keymap.set("n", "]<Space>", "o<Esc>", { desc = "Add blank line below" })
keymap.set("n", "[<Space>", "O<Esc>", { desc = "Add blank line above" })

-- Git hunks handled in gitsigns.lua (]g/[g)

-- ============================================================================
-- MATCH MODE (m prefix) - Brackets and Surround
-- ============================================================================

-- Match brackets (helix: mm)
-- Note: We use mm for matching because % is remapped to select-all (Helix style)
-- Matchit is disabled via vim.g.loaded_matchit = 1 in init.lua
keymap.set("n", "mm", "%", { desc = "Jump to matching bracket" })
keymap.set("v", "mm", "%", { desc = "Jump to matching bracket" })

-- Text objects (helix: ma/mi for around/inner)
-- Usage: miw = select inner word, maf = select around function
keymap.set("n", "mi", "vi", { remap = true, desc = "Select inner textobject" })
keymap.set("n", "ma", "va", { remap = true, desc = "Select around textobject" })

-- Surround operations (helix: ms/mr/md)
-- Handled by mini.surround plugin in mini-surround.lua

-- ============================================================================
-- SELECTION AND EDITING
-- ============================================================================

-- Select all (helix: %)
-- Note: Requires vim.g.loaded_matchit = 1 in init.lua to prevent matchit override
keymap.set("n", "%", "<cmd>normal! ggVG<CR>", { desc = "Select entire buffer" })

-- Line selection (helix: x/X)
keymap.set("n", "x", "V", { desc = "Select line" })
keymap.set("v", "x", "j", { desc = "Extend selection down" })
keymap.set("n", "X", "V", { desc = "Select line (linewise)" })
keymap.set("v", "X", "V", { desc = "Convert to linewise selection" })
keymap.set("v", "<A-x>", "V", { desc = "Shrink to line bounds" })

-- Delete and change (helix style - no yank by default)
keymap.set("n", "d", '"_x', { desc = "Delete char under cursor" })
keymap.set("n", "c", '"_xi', { desc = "Change char under cursor" })
keymap.set("v", "d", '"_d', { desc = "Delete selection" })
keymap.set("v", "c", '"_c', { desc = "Change selection" })

-- Delete/change with motions (vim style - use Alt modifier)
keymap.set("n", "<A-d>", '"_d', { desc = "Delete motion (no yank)" })
keymap.set("n", "<A-c>", '"_c', { desc = "Change motion (no yank)" })

-- Replace operations (helix: r/R)
keymap.set("v", "r", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"_c', true, false, true), "n", false)
  local char = vim.fn.getcharstr()
  if char:match("%w") or char:match("%p") or char == " " then
    local count = vim.fn.col("'>") - vim.fn.col("'<") + 1
    vim.api.nvim_put({ string.rep(char, count) }, "c", true, true)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { desc = "Replace selection with char" })
keymap.set("v", "R", '"_d"0P', { desc = "Replace with yanked text" })
keymap.set("n", "R", 'vl"_d"0P', { desc = "Replace char with yanked" })

-- Case transformation (helix: ~ toggle, ` lowercase, Alt-` uppercase)
keymap.set("n", "`", "vul", { desc = "Lowercase char" })
keymap.set("v", "`", "u", { desc = "Lowercase selection" })
keymap.set("n", "<A-`>", "vUl", { desc = "Uppercase char" })
keymap.set("v", "<A-`>", "U", { desc = "Uppercase selection" })

-- Paste without yanking (helix-style)
keymap.set("v", "p", '"_dP', { desc = "Paste over selection" })

-- Duplicate selection (Alt+Shift+j/k in visual mode only)
-- Note: Normal mode removed due to terminal conflicts with <A-j>/<A-k> (Zellij navigation)
-- To duplicate a line: select it first with 'x', then use <A-S-j> or <A-S-k>
keymap.set("x", "<A-S-j>", ":<C-u>'<,'>t'><CR>gv", { desc = "Duplicate selection down", silent = true })
keymap.set("x", "<A-S-k>", ":<C-u>'<,'>t'<-1<CR>gv", { desc = "Duplicate selection up", silent = true })

-- Join lines (helix: J)
keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- Indentation (stay in visual mode)
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines (using Ctrl-Shift to avoid conflict with terminal navigation)
keymap.set("n", "<C-S-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<C-S-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
keymap.set("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Repeat last motion (helix: Alt-.)
keymap.set({ "n", "x", "o" }, "<A-.>", ";", { remap = true, desc = "Repeat last motion" })

-- Undo/Redo (helix: u/U)
keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Macros (helix: Q record, q replay - swapped from vim default)
keymap.set("n", "Q", "q", { desc = "Record macro" })
keymap.set("n", "q", "@q", { desc = "Replay macro q" })

-- Increment/Decrement (helix: Ctrl-a/Ctrl-x - vim default)

-- ============================================================================
-- VIEW MODE (z prefix) - Scrolling and Centering
-- ============================================================================

-- Center cursor (helix: zc/zm)
keymap.set("n", "zc", "zz", { desc = "Center cursor line" })
keymap.set("n", "zz", "zz", { desc = "Center cursor line" })
keymap.set("n", "zm", "zz", { desc = "Center cursor line" })
keymap.set("n", "zt", "zt", { desc = "Cursor to window top" })
keymap.set("n", "zb", "zb", { desc = "Cursor to window bottom" })

-- Scroll view (helix: zj/zk)
keymap.set("n", "zj", "<C-e>", { desc = "Scroll view down" })
keymap.set("n", "zk", "<C-y>", { desc = "Scroll view up" })

-- Half-page scroll (keep centered)
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up" })

-- Keep centered when searching
keymap.set("n", "n", "nzzzv", { desc = "Next search match" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search match" })

-- ============================================================================
-- INSERT MODE (helix style)
-- ============================================================================

-- Delete word backward (helix: Ctrl-w or Alt-Backspace)
keymap.set("i", "<C-w>", "<C-w>", { desc = "Delete word backward" })
keymap.set("i", "<A-BS>", "<C-w>", { desc = "Delete word backward" })

-- Delete word forward (helix: Alt-d)
keymap.set("i", "<A-d>", "<C-o>dw", { desc = "Delete word forward" })

-- Kill to line start (helix: Ctrl-u)
keymap.set("i", "<C-u>", "<C-u>", { desc = "Delete to line start" })

-- Kill to line end (helix: Ctrl-k)
keymap.set("i", "<C-k>", "<C-o>D", { desc = "Delete to line end" })

-- ============================================================================
-- SHELL COMMANDS (helix style)
-- ============================================================================

-- Shell pipe (helix: |)
keymap.set("v", "|", ":!", { desc = "Pipe selection through shell" })

-- Shell insert output (helix: !)
keymap.set("n", "!", ":r!", { desc = "Insert shell command output" })
