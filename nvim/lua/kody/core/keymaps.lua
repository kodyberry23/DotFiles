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

-- Disable 's' in normal mode (only used in VM multi-cursor mode)
keymap.set("n", "s", "<Nop>", { desc = "Disable substitute command" })

-- Exit insert mode without moving cursor back
keymap.set("i", "<Esc>", "<Esc>`^", { desc = "Exit insert mode, keep cursor position" })

-- Note: <C-s> not mapped to save (use :w or ZZ to save, Helix-style)

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

-- Yank and keep cursor at end of selection
keymap.set("v", "y", "y`>", { desc = "Yank and move to end" })

-- Clipboard operations (helix: space+y/p for system clipboard)
keymap.set("v", "<leader>y", '"+y`>', { desc = "Yank to clipboard" })
keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap.set("n", "<leader>P", '"+P', { desc = "Paste before from clipboard" })
-- Visual-mode variants use "_d first so the replaced selection doesn't clobber
-- the unnamed register (which is aliased to + via clipboard=unnamedplus).
keymap.set("v", "<leader>p", '"_d"+P', { desc = "Paste from clipboard" })
keymap.set("v", "<leader>P", '"_d"+P', { desc = "Paste before from clipboard" })
keymap.set("n", "<leader>R", '"_x"+P', { desc = "Replace from clipboard" })
keymap.set("v", "<leader>R", '"_d"+P', { desc = "Replace from clipboard" })

-- Telescope picker (helix: space+')
keymap.set("n", "<leader>'", "<cmd>Telescope resume<CR>", { desc = "Resume last picker" })

-- Hover documentation (helix: space+k)
keymap.set("n", "<leader>k", function() vim.lsp.buf.hover({ max_width = 100, max_height = 30 }) end, { desc = "Hover docs" })

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

-- Directional pane navigation is handled via Alt-h/j/k/l through zellij-nav.nvim
-- for seamless movement between Neovim windows and Zellij panes.

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
keymap.set("n", "gh", "0", { desc = "Go to line start" })
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
-- Use function for gl in visual mode: $ goes one past EOL, we want to stay on last char
keymap.set("o", "gl", "$", { desc = "To line end" })
keymap.set("x", "gl", function()
  local line_len = #vim.api.nvim_get_current_line()
  if line_len > 0 then
    vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), line_len - 1 })
  end
end, { desc = "To line end" })
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
keymap.set("v", "D", 'd', { desc = "Delete selection (yank)" })
keymap.set("v", "c", '"_c', { desc = "Change selection" })

-- Delete/change with motions (vim style - use Alt modifier)
keymap.set("n", "<A-d>", '"_d', { desc = "Delete motion (no yank)" })
keymap.set("n", "<A-c>", '"_c', { desc = "Change motion (no yank)" })

-- Replace operations (helix: r/R).
-- helix r: replaces every char in the selection with the typed one (newlines
--   preserved). Uses a throwaway register "z" so "" / "0 stay untouched.
-- helix R: replaces selection with last-yanked text. "_d routes the delete to
--   the black hole so the replaced text doesn't clobber any register.
keymap.set("x", "r", function()
  local char = vim.fn.getcharstr()
  if char == "" or char == "\27" then return end
  local save, save_type = vim.fn.getreg("z"), vim.fn.getregtype("z")
  vim.cmd('noautocmd normal! "zy')
  vim.fn.setreg("z", (vim.fn.getreg("z"):gsub("[^\r\n]", char)), vim.fn.getregtype("z"))
  vim.cmd('noautocmd normal! gv"_d"zP')
  vim.fn.setreg("z", save, save_type)
end, { desc = "Replace selection with char" })
keymap.set("v", "R", '"_d"0P', { desc = "Replace with yanked text" })
keymap.set("n", "R", '"_x"0P', { desc = "Replace char with yanked" })

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

-- ============================================================================
-- HELIX-STYLE MULTI-CURSOR MAPPINGS
-- Reference: https://docs.helix-editor.com/keymap.html#selection-manipulation
-- Integrated with vim-visual-multi plugin
-- ============================================================================

-- C - Add cursor down (create cursors vertically)
-- Alt-C - Add cursor up (create cursors vertically)
-- IMPORTANT: These mappings are defined in vim-visual-multi.lua using <Plug> mappings
-- DO NOT define C or Alt-C mappings here - they will conflict with the plugin!
--
-- How it works:
-- - Normal mode: C adds cursor on the line below, Alt-C adds cursor above
-- - Press C/Alt-C repeatedly to add more cursors
-- - Cursors are added at the same column, shorter lines are skipped
-- - Ctrl-Down and Ctrl-Up are aliases for C and Alt-C
-- - Visual mode: C creates cursors from the visual selection

-- * - search_selection_detect_word_boundaries: Use word under cursor as search pattern
-- In Helix, this searches with word boundaries (\b) automatically
-- In VM mode, this will select all matches of the word
keymap.set("n", "*", function()
  local vm_active = vim.fn.exists("*vm#is_active") == 1 and vim.fn["vm#is_active"]() == 1
  if vm_active then
    -- In VM mode, use VM's find word feature
    vim.cmd("normal! *")
  else
    -- In normal mode, start VM with word under cursor
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(VM-Find-Under)", true, false, true), "m", false)
  end
end, { desc = "Search word under cursor / Start multi-cursor on word" })

-- ; - collapse_selection: Collapse to single cursor (Helix style)
-- In Helix, ; collapses selection to cursor position
-- In VM mode, this collapses all selections to single cursor
-- In normal mode, this is remapped to repeat last f/t/F/T motion via Alt-.
keymap.set("n", ";", function()
  local vm_active = vim.fn.exists("*vm#is_active") == 1 and vim.fn["vm#is_active"]() == 1
  if vm_active then
    -- Collapse to single cursor in VM mode
    vim.cmd("call vm#commands#toggle_single_region()")
  else
    -- In normal mode, repeat last f/t/F/T motion (Vim default behavior)
    vim.api.nvim_feedkeys(";", "n", false)
  end
end, { desc = "Collapse to single cursor (VM) / Repeat f/t motion" })

-- , - keep_primary_selection: Keep only primary selection
-- In Helix, , keeps only the primary selection and removes all others
-- When not in VM mode, selects the current line (same as 'x')
keymap.set("n", ",", function()
  local vm_active = vim.fn.exists("*vm#is_active") == 1 and vim.fn["vm#is_active"]() == 1
  if vm_active then
    -- In VM: keep only primary selection (collapse to one, but stay in VM)
    vim.cmd("call vm#commands#toggle_single_region()")
  else
    -- Fallback: Vim default - reverse repeat of f/t motion
    vim.api.nvim_feedkeys(",", "n", false)
  end
end, { desc = "Keep primary selection / Reverse repeat f/t motion" })

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
-- ============================================================================
-- HELIX MULTI-CURSOR & SELECTION WORKFLOW
-- ============================================================================
-- CRITICAL KEYMAPS FOR HELIX-LIKE MULTI-CURSOR EDITING:
--
-- START MULTI-CURSOR:
--   <C-n>           - Start on word under cursor (find under), press again for next match
--   *               - Search word under cursor with word boundaries (start VM on all matches)
--   C               - Add cursor on line below (at same column)
--   <A-C>           - Add cursor on line above (at same column)
--   <C-Down/Up>     - Alternative to C/Alt-C (same functionality)
--   v then \\c      - Create cursors from visual selection
--   %               - Select entire file (then use s to select regex matches)
--
-- EDIT WITH MULTIPLE CURSORS:
--   n / N           - Next/previous match (extends selection in VM mode)
--   q / Q           - Skip or remove current selection
--   <Tab>           - Switch between cursor mode and extend mode
--
-- ADD MORE CURSORS:
--   C               - Add cursor on next line (press multiple times to add more)
--   <A-C>           - Add cursor on previous line (press multiple times to add more)
--   <C-Down>        - Same as C
--   <C-Up>          - Same as Alt-C
--
-- MANIPULATE SELECTIONS:
--   s               - Select all regex matches inside selections
--   S               - Split selection into sub-selections on matches
--   <A-s>           - Split selection on newlines
--   &               - Align selections in columns
--   _               - Trim whitespace from selections
--   ;               - Collapse to single cursor (exit VM mode)
--   ,               - Keep ONLY primary selection (alternative to ;)
--   <A-,>           - Remove primary selection
--   <A-;>           - Flip selection (reverse direction)
--   <A-:>           - Ensure selections face forward
--   <A-minus>       - Merge all selections
--   <A-_>           - Merge consecutive selections
--   ( / )           - Rotate to prev/next selection
--   <A-(> / <A-)>   - Rotate selection contents backward/forward
--
-- SEARCH WITH MULTIPLE SELECTIONS:
--   /               - Start search (adds all matches to selections)
--   *               - Use word under cursor as search pattern (word boundaries)
--   <A-*>           - Use selection as exact search pattern (no word boundaries)
--   n / N           - Next/previous match (extend selection in VM)
--
-- FILTER SELECTIONS:
--   K               - Keep only selections matching regex pattern
--   <A-K>           - Remove selections matching regex pattern
--
-- TREE-SITTER SELECTIONS (when available):
--   <A-o>/<A-Up>    - Expand to parent syntax node
--   <A-i>/<A-Down>  - Shrink to child syntax node
--   <A-p>/<A-Left>  - Select previous sibling
--   <A-n>/<A-Right> - Select next sibling
--   <A-a>           - Select all siblings
--   <A-I>           - Select all children
--   <A-e>           - Move to end of parent node
--   <A-b>           - Move to start of parent node
--
-- OPERATIONS ON SELECTIONS:
--   d / <A-d>       - Delete selections (no yank for d)
--   D               - Delete and yank selections
--   c / <A-c>       - Change selections (no yank for c)
--   y               - Yank selections
--   p               - Paste over selections
--   >/<             - Indent/unindent selections
--   ~               - Toggle case
--   `/<A-`>         - Lowercase/uppercase
--   J               - Join lines inside selections
--   <A-J>           - Join lines and select inserted space
--   p               - Paste and replace selections
--   >/<            - Indent/unindent
--   ~               - Toggle case
--   `/<A-`>         - Lowercase/uppercase
--
-- EXIT MULTI-CURSOR:
--   Escape          - Exit VM mode, back to single cursor
--   ,               - Keep primary selection only (collapses to 1 cursor)
--
-- EXAMPLES:
--   1. Replace multiple words:
--      <C-n>          - Select first word
--      n n n          - Select next 3 matches (4 total selections)
--      c              - Change all 4 at once, enter insert mode
--      [type new text]
--      Escape         - Exit insert, back to normal
--
--   2. Add cursor to next line:
--      C              - Copy current line to next line
--      C              - Copy to line below that
--      (manual edits)
--      Escape         - Exit multi-cursor
--
--   3. Search & edit multiple:
--      /pattern       - Search, adds all matches as selections
--      n n            - Add more matches (optional)
--      d              - Delete all matches
--
-- See: vim-visual-multi.lua for VM plugin configuration
-- ============================================================================