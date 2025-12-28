# Neovim Keymaps Reference (Helix-Style)

This document tracks all keymaps in the Neovim configuration to prevent conflicts when adding new bindings.
Based on [Helix Editor Keymap](https://docs.helix-editor.com/keymap.html).

**Last Updated:** 2024-12-27 (Fixed Helix compatibility issues)

---

## Table of Contents
- [Leader Keys](#leader-keys)
- [Normal Mode - Core Keymaps](#normal-mode---core-keymaps)
- [Space Mode (Leader)](#space-mode-leader)
- [Goto Mode (g prefix)](#goto-mode-g-prefix)
- [View Mode (z prefix)](#view-mode-z-prefix)
- [Match Mode (m prefix)](#match-mode-m-prefix)
- [Window Mode (Ctrl-w / leader+w)](#window-mode-ctrl-w--leaderw)
- [Unimpaired (]/[ prefix)](#unimpaired--prefix)
- [Insert Mode](#insert-mode)
- [Visual Mode / Select Mode](#visual-mode--select-mode)
- [Completion (nvim-cmp)](#completion-nvim-cmp)
- [LSP Keymaps](#lsp-keymaps)
- [Git (gitsigns)](#git-gitsigns)
- [File Explorer (Oil)](#file-explorer-oil)
- [Telescope](#telescope)
- [Zellij Navigation](#zellij-navigation)
- [Shell Commands](#shell-commands)

---

## Leader Keys

| Key | Description | Source |
|-----|-------------|--------|
| `Space` | Leader key | lazy.lua |
| `\` | Local leader | lazy.lua |

---

## Normal Mode - Core Keymaps

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<Esc>` | `<cmd>nohlsearch<CR>` | Clear search highlights | keymaps.lua |
| `x` | `V` | Select line (helix style) | keymaps.lua |
| `X` | `Vg_` | Extend to line bounds | keymaps.lua |
| `%` | `ggVG` | Select all | keymaps.lua |
| `J` | `mzJ`z` | Join lines (keep cursor) | keymaps.lua |
| `C` | `yyp` | Copy line down | keymaps.lua |
| `<A-C>` | `yyP` | Copy line up | keymaps.lua |
| `R` | `"0p` | Replace with yanked | keymaps.lua |
| `U` | `<C-r>` | Redo | keymaps.lua |
| `Q` | `q` | Record macro | keymaps.lua |
| `q` | `@q` | Replay macro | keymaps.lua |
| `~` | (vim default) | Switch case | vim default |
| `` ` `` | `gu` | Lowercase char | keymaps.lua |
| `` <A-`> `` | `gU` | Uppercase char | keymaps.lua |
| `<A-d>` | `"_d` | Delete without yanking (normal mode) | keymaps.lua |
| `<A-c>` | `"_c` | Change without yanking (normal mode) | keymaps.lua |
| `R` | (function) | Replace char with yanked text | keymaps.lua |
| `<C-d>` | `<C-d>zz` | Scroll down (centered) | keymaps.lua |
| `<C-u>` | `<C-u>zz` | Scroll up (centered) | keymaps.lua |
| `n` | `nzzzv` | Next match (centered) | keymaps.lua |
| `N` | `Nzzzv` | Prev match (centered) | keymaps.lua |
| `<C-s>` | `<cmd>w<CR><Esc>` | Save file | keymaps.lua |
| `<C-S-j>` | Move line down | Move line down | keymaps.lua |
| `<C-S-k>` | Move line up | Move line up | keymaps.lua |
| `!` | `:r!` | Insert shell output | keymaps.lua |

---

## Space Mode (Leader)

### Pickers (Telescope)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>f` | `Telescope find_files` | Find files | telescope.lua |
| `<leader>F` | `Telescope find_files hidden=true` | Find files (hidden) | telescope.lua |
| `<leader>b` | `Telescope buffers` | Buffer picker | telescope.lua |
| `<leader>j` | `Telescope jumplist` | Jumplist picker | telescope.lua |
| `<leader>g` | `Telescope git_status` | Changed files (git) | telescope.lua |
| `<leader>s` | `Telescope lsp_document_symbols` | Document symbols | telescope.lua |
| `<leader>S` | `Telescope lsp_workspace_symbols` | Workspace symbols | telescope.lua |
| `<leader>/` | `Telescope live_grep` | Global search | telescope.lua |
| `<leader>?` | `Telescope commands` | Command palette | telescope.lua |
| `<leader>d` | `Telescope diagnostics bufnr=0` | Document diagnostics | telescope.lua / lspconfig.lua |
| `<leader>D` | `Telescope diagnostics` | Workspace diagnostics | telescope.lua / lspconfig.lua |

### LSP Actions

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>a` | `vim.lsp.buf.code_action` | Code action | lspconfig.lua |
| `<leader>r` | `vim.lsp.buf.rename` | Rename symbol | lspconfig.lua |
| `<leader>rs` | `:LspRestart<CR>` | Restart LSP | lspconfig.lua |

### Comments

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>c` | `gcc` (remap) | Toggle comment | keymaps.lua |
| `<leader>C` | `gbc` (remap) | Toggle block comment | keymaps.lua |

### Clipboard

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>y` | `"+y` | Yank to clipboard | keymaps.lua |
| `<leader>Y` | `"+Y` | Yank line to clipboard | keymaps.lua |
| `<leader>p` | `"+p` | Paste from clipboard | keymaps.lua |
| `<leader>P` | `"+P` | Paste before from clipboard | keymaps.lua |
| `<leader>R` | `"+P` | Replace from clipboard | keymaps.lua |

### Additional Space Mode

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>k` | `vim.lsp.buf.hover` | Hover docs | keymaps.lua |
| `<leader>'` | `Telescope resume` | Last picker | keymaps.lua |

### File Explorer

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>ee` | `NvimTreeToggle` | Toggle explorer | keymaps.lua |
| `<leader>ef` | `NvimTreeFindFile` | Find in explorer | keymaps.lua |
| `<leader>ec` | `NvimTreeCollapse` | Collapse explorer | keymaps.lua |
| `<leader>er` | `NvimTreeRefresh` | Refresh explorer | keymaps.lua |

### Buffer

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>bd` | `<cmd>bdelete<CR>` | Delete buffer | keymaps.lua |
| `<leader>bD` | `<cmd>bdelete!<CR>` | Force delete buffer | keymaps.lua |

### Quit

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>qq` | `<cmd>qa<CR>` | Quit all | keymaps.lua |
| `<leader>qw` | `<cmd>wqa<CR>` | Save and quit all | keymaps.lua |
| `<leader>qQ` | `<cmd>qa!<CR>` | Force quit all | keymaps.lua |

### UI Toggles

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>uw` | `<cmd>set wrap!<CR>` | Toggle wrap | keymaps.lua |
| `<leader>un` | `<cmd>set relativenumber!<CR>` | Toggle relative number | keymaps.lua |
| `<leader>us` | `<cmd>set spell!<CR>` | Toggle spell | keymaps.lua |
| `<leader>ul` | `<cmd>set list!<CR>` | Toggle listchars | keymaps.lua |

### Window (leader+w)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>wv` | `<cmd>vsplit<CR>` | Vertical split | keymaps.lua |
| `<leader>ws` | `<cmd>split<CR>` | Horizontal split | keymaps.lua |
| `<leader>wq` | `<cmd>close<CR>` | Close window | keymaps.lua |
| `<leader>wo` | `<cmd>only<CR>` | Close others | keymaps.lua |
| `<leader>ww` | `<C-w>w` | Cycle window | keymaps.lua |
| `<leader>w=` | `<C-w>=` | Equalize windows | keymaps.lua |
| `<leader>wH` | `<C-w>H` | Move window left | keymaps.lua |
| `<leader>wJ` | `<C-w>J` | Move window down | keymaps.lua |
| `<leader>wK` | `<C-w>K` | Move window up | keymaps.lua |
| `<leader>wL` | `<C-w>L` | Move window right | keymaps.lua |

---

## Goto Mode (g prefix)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `gg` | (default vim) | Go to first line | vim default |
| `ge` | `G` | Go to last line | keymaps.lua |
| `gh` | `^` | Go to line start | keymaps.lua |
| `gl` | `vim.diagnostic.open_float` | Show line diagnostics (LSP) | lspconfig.lua |
| `gs` | `^` | Go to first non-blank | keymaps.lua |
| `gn` | `<cmd>bnext<CR>` | Next buffer | keymaps.lua |
| `gp` | `<cmd>bprevious<CR>` | Previous buffer | keymaps.lua |
| `ga` | `<C-^>` | Last accessed file | keymaps.lua |
| `gt` | `H` | Go to window top | keymaps.lua |
| `gc` | `M` | Go to window center | keymaps.lua |
| `gb` | `L` | Go to window bottom | keymaps.lua |
| `g.` | `` `. `` | Go to last modification | keymaps.lua |
| `gd` | `Telescope lsp_definitions` | Go to definition | lspconfig.lua |
| `gD` | `vim.lsp.buf.declaration` | Go to declaration | lspconfig.lua |
| `gy` | `Telescope lsp_type_definitions` | Go to type definition | lspconfig.lua |
| `gr` | `Telescope lsp_references` | Go to references | lspconfig.lua |
| `gi` | `Telescope lsp_implementations` | Go to implementation | lspconfig.lua |

---

## View Mode (z prefix)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `zz` | `zz` | Center cursor | keymaps.lua |
| `zc` | `zz` | Center cursor (helix style) | keymaps.lua |
| `zt` | `zt` | Cursor to top | keymaps.lua |
| `zb` | `zb` | Cursor to bottom | keymaps.lua |
| `zm` | `zz` | Center cursor (middle) | keymaps.lua |
| `zj` | `<C-e>` | Scroll down | keymaps.lua |
| `zk` | `<C-y>` | Scroll up | keymaps.lua |

---

## Match Mode (m prefix)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `mm` | `%` | Match brackets | keymaps.lua |
| `ms<char>` | Surround add | Add surrounding (✅ matches Helix) | mini-surround.lua |
| `mr<from><to>` | Surround replace | Replace surrounding (✅ matches Helix) | mini-surround.lua |
| `md<char>` | Surround delete | Delete surrounding (✅ matches Helix) | mini-surround.lua |
| `ma` | `a` (operator) | Around textobject | keymaps.lua |
| `mi` | `i` (operator) | Inner textobject | keymaps.lua |

**Note**: Surround operations work in both normal mode (with text objects like `msiw(`) and visual mode (select then `ms(`), matching Helix's visual mode behavior.

---

## Treesitter Text Objects

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `af` | Select around function | Around function | treesitter-textobjects.lua |
| `if` | Select inner function | Inner function | treesitter-textobjects.lua |
| `ac` | Select around class | Around class | treesitter-textobjects.lua |
| `ic` | Select inner class | Inner class | treesitter-textobjects.lua |
| `aa` | Select around argument | Around argument | treesitter-textobjects.lua |
| `ia` | Select inner argument | Inner argument | treesitter-textobjects.lua |
| `ab` | Select around block | Around block | treesitter-textobjects.lua |
| `ib` | Select inner block | Inner block | treesitter-textobjects.lua |
| `aC` | Select around comment | Around comment | treesitter-textobjects.lua |
| `iC` | Select inner comment | Inner comment | treesitter-textobjects.lua |
| `<A-n>` | Swap with next param | Swap next | treesitter-textobjects.lua |
| `<A-p>` | Swap with prev param | Swap prev | treesitter-textobjects.lua |

---

## Window Mode (Ctrl-w / leader+w)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<C-h>` | `<C-w>h` | Window left | keymaps.lua |
| `<C-j>` | `<C-w>j` | Window down | keymaps.lua |
| `<C-k>` | `<C-w>k` | Window up | keymaps.lua |
| `<C-l>` | `<C-w>l` | Window right | keymaps.lua |

---

## Unimpaired (]/[ prefix)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `]d` | `vim.diagnostic.goto_next` | Next diagnostic | keymaps.lua / lspconfig.lua |
| `[d` | `vim.diagnostic.goto_prev` | Prev diagnostic | keymaps.lua / lspconfig.lua |
| `]D` | (function) | Last diagnostic in document | keymaps.lua |
| `[D` | (function) | First diagnostic in document | keymaps.lua |
| `]b` | `<cmd>bnext<CR>` | Next buffer | keymaps.lua |
| `[b` | `<cmd>bprevious<CR>` | Prev buffer | keymaps.lua |
| `]q` | `<cmd>cnext<CR>` | Next quickfix | keymaps.lua |
| `[q` | `<cmd>cprev<CR>` | Prev quickfix | keymaps.lua |
| `]<Space>` | `o<Esc>` | Add line below | keymaps.lua |
| `[<Space>` | `O<Esc>` | Add line above | keymaps.lua |
| `]g` | `gs.next_hunk()` | Next git change | gitsigns.lua |
| `[g` | `gs.prev_hunk()` | Prev git change | gitsigns.lua |
| `]p` | `}` | Next paragraph | keymaps.lua |
| `[p` | `{` | Prev paragraph | keymaps.lua |
| `]f` | Next function start | Next function | treesitter-textobjects.lua |
| `[f` | Prev function start | Prev function | treesitter-textobjects.lua |
| `]F` | Next function end | Next function end | treesitter-textobjects.lua |
| `[F` | Prev function end | Prev function end | treesitter-textobjects.lua |
| `]t` | Next class start | Next class | treesitter-textobjects.lua |
| `[t` | Prev class start | Prev class | treesitter-textobjects.lua |
| `]a` | Next argument | Next argument | treesitter-textobjects.lua |
| `[a` | Prev argument | Prev argument | treesitter-textobjects.lua |
| `]c` | Next comment | Next comment | treesitter-textobjects.lua |
| `[c` | Prev comment | Prev comment | treesitter-textobjects.lua |

---

## Insert Mode

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<C-s>` | `<cmd>w<CR><Esc>` | Save file | keymaps.lua |
| `<C-w>` | `<C-w>` | Delete word backward | keymaps.lua |
| `<A-BS>` | `<C-w>` | Delete word backward | keymaps.lua |
| `<A-d>` | `<C-o>dw` | Delete word forward | keymaps.lua |
| `<C-u>` | `<C-u>` | Kill to line start | keymaps.lua |
| `<C-k>` | `<C-o>D` | Kill to line end | keymaps.lua |

---

## Visual Mode / Select Mode

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `x` | `j` | Extend line down | keymaps.lua |
| `X` | Extend to line bounds | Extend to line bounds | keymaps.lua |
| `;` | Repeat last move | Repeat motion forward | treesitter-textobjects.lua |
| `,` | Repeat last move | Repeat motion backward | treesitter-textobjects.lua |
| `d` | `"_d` | Delete selection (no yank, Helix style) | keymaps.lua |
| `c` | `"_c` | Change selection (no yank, Helix style) | keymaps.lua |
| `r` | (function) | Replace selection with character | keymaps.lua |
| `C` | `yPgv` | Copy selection | keymaps.lua |
| `R` | `"_d"0P` | Replace selection with yanked text | keymaps.lua |
| `` ` `` | `u` | Lowercase selection | keymaps.lua |
| `` <A-`> `` | `U` | Uppercase selection | keymaps.lua |
| `<A-;>` | `o` | Flip selection | keymaps.lua |
| `<A-:>` | (function) | Ensure selection forward | keymaps.lua |
| `<A-s>` | (function) | Split on newline | keymaps.lua |
| `\|` | `:!` | Shell pipe | keymaps.lua |
| `mm` | `%` | Match brackets | keymaps.lua |
| `<` | `<gv` | Indent left (stay visual) | keymaps.lua |
| `>` | `>gv` | Indent right (stay visual) | keymaps.lua |
| `<C-S-j>` | Move selection down | Move selection down | keymaps.lua |
| `<C-S-k>` | Move selection up | Move selection up | keymaps.lua |
| `p` | `"_dP` | Paste (no yank) | keymaps.lua |
| `<leader>c` | `gc` (remap) | Toggle comment | keymaps.lua |
| `<leader>C` | `gb` (remap) | Toggle block comment | keymaps.lua |
| `<leader>y` | `"+y` | Yank to clipboard | keymaps.lua |
| `<leader>p` | `"+p` | Paste from clipboard | keymaps.lua |
| `<leader>P` | `"+P` | Paste before from clipboard | keymaps.lua |
| `<leader>R` | `"+p` | Replace from clipboard | keymaps.lua |
| `<C-s>` | `<cmd>w<CR><Esc>` | Save file | keymaps.lua |

---

## Completion (nvim-cmp)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<C-b>` | Scroll docs up | Scroll docs -4 | nvim-cmp.lua |
| `<C-f>` | Scroll docs down | Scroll docs +4 | nvim-cmp.lua |
| `<C-n>` | Select next item | Next completion | nvim-cmp.lua |
| `<C-p>` | Select prev item | Prev completion | nvim-cmp.lua |
| `<C-Space>` | Complete | Trigger completion | nvim-cmp.lua |
| `<CR>` | Confirm | Confirm selection | nvim-cmp.lua |
| `<C-y>` | Confirm | Confirm selection | nvim-cmp.lua |
| `<S-CR>` | Confirm replace | Confirm with replace | nvim-cmp.lua |
| `<C-CR>` | Abort | Abort completion | nvim-cmp.lua |
| `<Tab>` | Select next | Next completion | nvim-cmp.lua |
| `<S-Tab>` | Select prev | Prev completion | nvim-cmp.lua |

---

## LSP Keymaps

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `K` | `vim.lsp.buf.hover` | Show hover docs | lspconfig.lua |
| `<C-k>` | `vim.lsp.buf.signature_help` | Signature help | lspconfig.lua |

---

## Git (gitsigns)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>hs` | `gs.stage_hunk` | Stage hunk | gitsigns.lua |
| `<leader>hr` | `gs.reset_hunk` | Reset hunk | gitsigns.lua |
| `<leader>hS` | `gs.stage_buffer` | Stage buffer | gitsigns.lua |
| `<leader>hR` | `gs.reset_buffer` | Reset buffer | gitsigns.lua |
| `<leader>hp` | `gs.preview_hunk` | Preview hunk | gitsigns.lua |
| `<leader>hi` | `gs.preview_hunk_inline` | Preview hunk inline | gitsigns.lua |
| `<leader>hb` | `gs.blame_line` | Blame line | gitsigns.lua |
| `<leader>hd` | `gs.diffthis` | Diff this | gitsigns.lua |
| `<leader>hD` | `gs.diffthis("~")` | Diff this ~ | gitsigns.lua |
| `<leader>td` | `gs.toggle_deleted` | Toggle deleted | gitsigns.lua |
| `ih` | Text object | Select hunk | gitsigns.lua |

---

## File Explorer (Oil)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `-` | `<cmd>Oil<CR>` | Open parent directory | oil.lua |
| `g?` | Show help | Show help | oil.lua (buffer) |
| `<CR>` | Select | Enter directory/file | oil.lua (buffer) |
| `l` | Select | Enter (Yazi style) | oil.lua (buffer) |
| `h` | Parent | Go up (Yazi style) | oil.lua (buffer) |
| `q` | Close | Close oil | oil.lua (buffer) |
| `<C-c>` | Close | Close oil | oil.lua (buffer) |
| `r` | Rename | Rename file/dir | oil.lua (buffer) |
| `.` | Toggle hidden | Toggle hidden files | oil.lua (buffer) |
| `<leader>r` | Refresh | Refresh oil | oil.lua (buffer) |
| `y` | Copy path | Copy entry path | oil.lua (buffer) |
| `<leader>y` | Copy path | Copy entry path | oil.lua (buffer) |
| `a` | Create | Create new file/dir | oil.lua (buffer) |

---

## Telescope

*Picker-specific keymaps use telescope defaults*

---

## Zellij Navigation

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<A-h>` | `ZellijNavigateLeft` | Navigate left (zellij) | zellij-nav.lua |
| `<A-j>` | `ZellijNavigateDown` | Navigate down (zellij) | zellij-nav.lua |
| `<A-k>` | `ZellijNavigateUp` | Navigate up (zellij) | zellij-nav.lua |
| `<A-l>` | `ZellijNavigateRight` | Navigate right (zellij) | zellij-nav.lua |

---

## Shell Commands

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `!` | `:r!` | Insert shell output | keymaps.lua |
| `\|` (visual) | `:!` | Shell pipe | keymaps.lua |

---

## Implemented Helix Keymaps Summary

### Normal Mode - ✅ Implemented
- `%` - Select all (helix style, replaces vim match bracket)
- `U` - Redo (helix style)
- `Q` - Record macro (swapped with q)
- `q` - Replay macro (swapped with Q)
- `C` - Copy line down
- `R` - Replace with yanked
- `` ` `` - Lowercase
- `` <A-`> `` - Uppercase
- `~` - Switch case (vim default, matches helix)
- `<A-d>` - Delete without yanking
- `<A-c>` - Change without yanking

### Goto Mode (g prefix) - ✅ Implemented
- `ga` - Last accessed file
- `gt` - Window top
- `gc` - Window center
- `gb` - Window bottom
- `g.` - Last modification

### Match Mode (m prefix) - ✅ Implemented
- `mm` - Match brackets
- `ms` - Surround add (placeholder, needs plugin)
- `mr` - Surround replace (placeholder, needs plugin)
- `md` - Surround delete (placeholder, needs plugin)
- `ma` - Around textobject
- `mi` - Inner textobject

### View Mode (z prefix) - ✅ Implemented
- `zc` - Center cursor
- `zm` - Center cursor (middle)
- `zj` - Scroll down
- `zk` - Scroll up

### Unimpaired - ✅ Implemented
- `]p` / `[p` - Next/prev paragraph
- `]f` / `[f` - Next/prev function
- `]t` / `[t` - Next/prev class
- `]a` / `[a` - Next/prev argument
- `]c` / `[c` - Next/prev comment
- `;` / `,` - Repeat last motion forward/backward

### Space Mode - ✅ Implemented
- `<leader>k` - Hover docs
- `<leader>'` - Last picker (telescope resume)
- `<leader>C` - Toggle block comments
- `<leader>R` - Replace from clipboard

### Visual/Select Mode - ✅ Implemented
- `<A-;>` - Flip selection
- `<A-:>` - Ensure selection forward
- `<A-s>` - Split on newline

---

## Still Available for Future Bindings

### Normal Mode
- `s` - Helix uses for select_regex (consider adding)
- `S` - Helix uses for split_selection (consider adding)

### Goto Mode
- `gm` - Helix: goto_last_modified_file
- `gf` - Helix: goto_file (vim default exists)
- `gw` - Helix: goto_word

### Unimpaired - Remaining
- `]T` / `[T` - Next/prev test (add custom query)
- `]G` / `[G` - Last/first git change

### Space Mode
- `<leader>h` - Select references (conflicts with git hunk group)
- `<leader>G` - Debug menu

---

## Conflict Notes

1. **`gl`** - ✅ **RESOLVED**: Removed from goto mode in keymaps.lua. Now only used for `diagnostic.open_float` in lspconfig.lua. Helix doesn't use `gl` in goto mode anyway.

2. **`<leader>r`** - Used for both Oil refresh (buffer-local) and LSP rename (buffer-local). No conflict as they're in different buffer contexts.

3. **`<leader>y`** - Used globally for clipboard AND in Oil for copy path. Oil version is buffer-local so it overrides in Oil buffers.

4. **`<C-k>`** - Used for LSP signature help. Conflicts with Helix insert mode `kill_to_line_end`. **Intentional deviation** - LSP signature help is more useful.

5. **`]d`/`[d`** - Defined in both keymaps.lua and lspconfig.lua (identical functionality, no actual conflict).

---

## Intentional Deviations from Helix

These are deliberate differences from Helix's default behavior:

1. **`;` and `,`** - Used for repeating treesitter text object motions instead of Helix's collapse/keep selection behavior. Added `<A-.>` as alias for Helix compatibility. Using `<Esc>` to collapse selection is more natural in Vim.

2. **`<C-k>` in insert mode** - LSP signature help instead of kill-to-line-end. The latter is available as part of `<C-u>` workflow or can use `<C-o>D`.

3. **Surround enhancements** - mini.surround supports text objects in normal mode (e.g., `msiw(`) in addition to Helix's visual mode workflow. This is a feature enhancement.

4. **`s` and `S` not implemented** - Helix's select_regex and split_selection are powerful but complex. These keys remain available for future implementation or other uses.

5. **Case operators `` ` `` and `` <A-`> ``** - Enhanced to work on single character in normal mode (Helix doesn't support this, only selections).

6. **Normal mode `d` and `c`** - Keep Vim's operator behavior (requiring motions/text objects). Only visual mode `d`/`c` match Helix (delete/change without yanking). Use `<A-d>`/`<A-c>` in normal mode to delete/change without yanking.

---

## Helix Compatibility Enhancements

Recent changes to match Helix behavior more closely:

### Delete and Change Operations
- **`d` in visual mode** - Now deletes selection without yanking (Helix style)
- **`c` in visual mode** - Now changes selection without yanking (Helix style)
- **`r` in visual mode** - Replaces selection with a single character
- **`R` in visual mode** - Replaces selection with yanked text (deletes to black hole, pastes from yank register)

These changes make visual mode editing match Helix's selection-first workflow while keeping normal mode operator behavior for Vim muscle memory.

---

## Last Updated

**2024-12-27** - Added Helix-style delete/change/replace in visual mode. Fixed `gl` conflict, corrected `]D`/`[D]` behavior, improved case operators, fixed blank line positioning, and documented surround compatibility.
