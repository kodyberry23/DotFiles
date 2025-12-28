
This allows `%` to be remapped to select-all (Helix style). The original bracket-matching functionality is preserved via `mm` in Match Mode.

---

## Normal Mode - Core Keymaps

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<Esc>` | `<cmd>nohlsearch<CR>` | Clear search highlights | keymaps.lua |
| `x` | `V` | Select line (helix style) | keymaps.lua |
| `X` | `V` | Select line (linewise) | keymaps.lua |
| `%` | `<cmd>normal! ggVG<CR>` | Select entire buffer (Helix style) | keymaps.lua |
| `d` | `"_x` | Delete char under cursor (no yank) | keymaps.lua |
| `c` | `"_xi` | Change char under cursor (no yank) | keymaps.lua |
| `J` | `mzJ`z` | Join lines (keep cursor position) | keymaps.lua |
| `C` | `yyp` | Duplicate line down | keymaps.lua |
| `<A-C>` | `yyP` | Duplicate line up | keymaps.lua |
| `R` | `vl"_d"0P` | Replace char with yanked text | keymaps.lua |
| `U` | `<C-r>` | Redo | keymaps.lua |
| `Q` | `q` | Record macro | keymaps.lua |
| `q` | `@q` | Replay macro q | keymaps.lua |
| `~` | (vim default) | Switch case | vim default |
| `` ` `` | `vul` | Lowercase char | keymaps.lua |
| `` <A-`> `` | `vUl` | Uppercase char | keymaps.lua |
| `<A-d>` | `"_d` | Delete motion (no yank) | keymaps.lua |
| `<A-c>` | `"_c` | Change motion (no yank) | keymaps.lua |
| `<C-d>` | `<C-d>zz` | Scroll half-page down (centered) | keymaps.lua |
| `<C-u>` | `<C-u>zz` | Scroll half-page up (centered) | keymaps.lua |
| `n` | `nzzzv` | Next search match (centered) | keymaps.lua |
| `N` | `Nzzzv` | Previous search match (centered) | keymaps.lua |
| `<C-s>` | `<cmd>w<CR><Esc>` | Save file | keymaps.lua |
| `<C-S-j>` | `<cmd>m .+1<CR>==` | Move line down | keymaps.lua |
| `<C-S-k>` | `<cmd>m .-2<CR>==` | Move line up | keymaps.lua |
| `!` | `:r!` | Insert shell command output | keymaps.lua |
| `<A-.>` | `;` | Repeat last motion | keymaps.lua |

---

## Multi-Cursor / Selection (vim-visual-multi)

**Helix-style multi-cursor and selection manipulation.** Start VM with `<C-n>` on a word.

### Starting VM Mode

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<C-n>` | Find Under | Start multi-cursor on word | vim-visual-multi.lua |
| `<C-Down>` | Add Cursor Down | Add cursor below | vim-visual-multi.lua |
| `<C-Up>` | Add Cursor Up | Add cursor above | vim-visual-multi.lua |
| `\\c` (visual) | Visual Cursors | Create cursors from selection | vim-visual-multi.lua |

### VM Selection Manipulation (Active when VM started)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `s` | Select Regex | Split selection by regex | vim-visual-multi.lua |
| `S` | Split Regions | Split into separate selections | vim-visual-multi.lua |
| `<A-s>` | Split on Newline | Split each selection on newlines | vim-visual-multi.lua |
| `<A-minus>` | Merge Regions | Merge all selections into one | vim-visual-multi.lua |
| `<A-_>` | Merge Consecutive | Merge consecutive selections | vim-visual-multi.lua |
| `&` | Align | Align selections in columns | vim-visual-multi.lua |
| `_` | Trim | Remove leading/trailing whitespace | vim-visual-multi.lua |
| `<A-;>` | Invert Direction | Flip selection direction | vim-visual-multi.lua |
| `<A-:>` | Ensure Forward | Ensure selections face forward | vim-visual-multi.lua |
| `,` | Toggle Single Region | Keep only primary selection | vim-visual-multi.lua |
| `<A-,>` | Remove Last Region | Remove primary selection | vim-visual-multi.lua |
| `(` | Goto Prev | Rotate to previous selection | vim-visual-multi.lua |
| `)` | Goto Next | Rotate to next selection | vim-visual-multi.lua |
| `<A-(>` | Rotate Contents Backward | Rotate selection contents prev | vim-visual-multi.lua |
| `<A-)>` | Rotate Contents Forward | Rotate selection contents next | vim-visual-multi.lua |
| `n` | Find Next | Next occurrence | vim-visual-multi.lua |
| `N` | Find Prev | Previous occurrence | vim-visual-multi.lua |
| `q` | Skip Region | Skip current, go to next | vim-visual-multi.lua |
| `Q` | Remove Region | Remove current region | vim-visual-multi.lua |
| `J` | Join Lines | Join lines inside selection | vim-visual-multi.lua |
| `<A-J>` | Join with Space | Join and select inserted space | vim-visual-multi.lua |
| `K` | Keep Selections | Keep only matching pattern | vim-visual-multi.lua |
| `<A-K>` | Remove Selections | Remove matching pattern | vim-visual-multi.lua |
| `<Tab>` | Switch Mode | Toggle cursor/extend mode | vim-visual-multi.lua |
| `u` | Undo | Undo with region restoration | vim-visual-multi.lua |
| `<C-r>` | Redo | Redo with region restoration | vim-visual-multi.lua |
| `R` | Replace Pattern | Replace pattern in selections | vim-visual-multi.lua |
| `m` + motion | Find Operator | Select all in range (e.g., `mip`) | vim-visual-multi.lua |

### VM Tree-sitter Navigation (Active when VM started)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<A-o>`, `<A-Up>` | Expand Region | Expand to parent syntax node | vim-visual-multi.lua |
| `<A-i>`, `<A-Down>` | Shrink Region | Shrink to child syntax node | vim-visual-multi.lua |
| `<A-p>`, `<A-Left>` | Prev Sibling | Select previous sibling node | vim-visual-multi.lua |
| `<A-n>`, `<A-Right>` | Next Sibling | Select next sibling node | vim-visual-multi.lua |
| `<A-a>` | All Siblings | Select all sibling nodes | vim-visual-multi.lua |
| `<A-I>`, `<A-S-Down>` | All Children | Select all children nodes | vim-visual-multi.lua |
| `<A-e>` | Parent End | Move to end of parent node | vim-visual-multi.lua |
| `<A-b>` | Parent Start | Move to start of parent node | vim-visual-multi.lua |

**Note:** VM mappings are buffer-local and only active when VM mode is started. Press `<Esc>` to exit VM mode.

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
| `<leader>'` | `Telescope resume` | Resume last picker | keymaps.lua |

### LSP Actions

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>a` | `vim.lsp.buf.code_action` | Code action | lspconfig.lua |
| `<leader>r` | `vim.lsp.buf.rename` | Rename symbol | lspconfig.lua |
| `<leader>rs` | `:LspRestart<CR>` | Restart LSP | lspconfig.lua |
| `<leader>k` | `vim.lsp.buf.hover` | Hover docs | keymaps.lua |

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
| `<leader>us` | `<cmd>set spell!<CR>` | Toggle spell check | keymaps.lua |
| `<leader>ul` | `<cmd>set list!<CR>` | Toggle listchars | keymaps.lua |

### Window (leader+w)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<leader>wv` | `<cmd>vsplit<CR>` | Vertical split | keymaps.lua |
| `<leader>ws` | `<cmd>split<CR>` | Horizontal split | keymaps.lua |
| `<leader>wq` | `<cmd>close<CR>` | Close window | keymaps.lua |
| `<leader>wo` | `<cmd>only<CR>` | Close other windows | keymaps.lua |
| `<leader>ww` | `<C-w>w` | Cycle to next window | keymaps.lua |
| `<leader>w=` | `<C-w>=` | Equalize window sizes | keymaps.lua |
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
| `gl` | `$` | Go to line end | keymaps.lua |
| `gs` | `^` | Go to first non-blank | keymaps.lua |
| `gn` | `<cmd>bnext<CR>` | Next buffer | keymaps.lua |
| `gp` | `<cmd>bprevious<CR>` | Previous buffer | keymaps.lua |
| `ga` | `<C-^>` | Go to alternate file | keymaps.lua |
| `gt` | `H` | Go to window top | keymaps.lua |
| `gm` | `M` | Go to window middle | keymaps.lua |
| `gb` | `L` | Go to window bottom | keymaps.lua |
| `g.` | `` `. `` | Go to last change | keymaps.lua |
| `gd` | `Telescope lsp_definitions` | Go to definition | lspconfig.lua |
| `gD` | `vim.lsp.buf.declaration` | Go to declaration | lspconfig.lua |
| `gy` | `Telescope lsp_type_definitions` | Go to type definition | lspconfig.lua |
| `gr` | `Telescope lsp_references` | Go to references | lspconfig.lua |
| `gi` | `Telescope lsp_implementations` | Go to implementation | lspconfig.lua |

**Visual/Operator-pending Mode Motions:**

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `ge` | `G` | To last line | keymaps.lua |
| `gh` | `0` | To line start | keymaps.lua |
| `gl` | `$` | To line end | keymaps.lua |
| `gs` | `^` | To first non-blank | keymaps.lua |
| `gt` | `H` | To window top | keymaps.lua |
| `gm` | `M` | To window middle | keymaps.lua |
| `gb` | `L` | To window bottom | keymaps.lua |

---

## View Mode (z prefix)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `zz` | `zz` | Center cursor line | keymaps.lua |
| `zc` | `zz` | Center cursor (helix style) | keymaps.lua |
| `zt` | `zt` | Cursor to window top | keymaps.lua |
| `zb` | `zb` | Cursor to window bottom | keymaps.lua |
| `zm` | `zz` | Center cursor (middle) | keymaps.lua |
| `zj` | `<C-e>` | Scroll view down | keymaps.lua |
| `zk` | `<C-y>` | Scroll view up | keymaps.lua |

---

## Match Mode (m prefix)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `mm` | `%` | Jump to matching bracket | keymaps.lua |
| `ms<char>` | Surround add | Add surrounding (✅ matches Helix) | mini-surround.lua |
| `mr<from><to>` | Surround replace | Replace surrounding (✅ matches Helix) | mini-surround.lua |
| `md<char>` | Surround delete | Delete surrounding (✅ matches Helix) | mini-surround.lua |
| `mi<obj>` | `vi<obj>` | Select inner textobject (e.g., `miw`, `mif`) | keymaps.lua |
| `ma<obj>` | `va<obj>` | Select around textobject (e.g., `maw`, `maf`) | keymaps.lua |

**Note**: Surround operations work in both normal mode (with text objects like `msiw(`) and visual mode (select then `ms(`), matching Helix's visual mode behavior.

---

## Text Objects (mini.ai + treesitter)

### Custom Text Objects (mini.ai)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `f` | Function | Function text object | mini-ai.lua |
| `t` | Type/Class | Class text object | mini-ai.lua |
| `a` | Argument | Argument/parameter text object | mini-ai.lua |
| `c` | Comment | Comment text object | mini-ai.lua |
| `m` | Matching | Any bracket/quote pair | mini-ai.lua |
| `g` | Git Hunk | Git hunk text object | mini-ai.lua |
| `o` | Conditional/Loop | Conditional or loop | mini-ai.lua |
| `b` | Block | Block text object | mini-ai.lua |

**Usage:** Combine with `mi`/`ma` (e.g., `mif` = select inner function, `mam` = select around matching brackets)

### Treesitter Navigation

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `;` | Repeat last move | Repeat motion forward | treesitter-textobjects.lua |
| `,` | Repeat last move | Repeat motion backward | treesitter-textobjects.lua |

---

## Window Mode (Ctrl-w / leader+w)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<C-h>` | `<C-w>h` | Move to left window | keymaps.lua |
| `<C-j>` | `<C-w>j` | Move to window below | keymaps.lua |
| `<C-k>` | `<C-w>k` | Move to window above | keymaps.lua |
| `<C-l>` | `<C-w>l` | Move to right window | keymaps.lua |

---

## Unimpaired (]/[ prefix)

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `]d` | `vim.diagnostic.goto_next` | Next diagnostic | keymaps.lua / lspconfig.lua |
| `[d` | `vim.diagnostic.goto_prev` | Previous diagnostic | keymaps.lua / lspconfig.lua |
| `]D` | (function) | Last diagnostic in document | keymaps.lua |
| `[D` | (function) | First diagnostic in document | keymaps.lua |
| `]b` | `<cmd>bnext<CR>` | Next buffer | keymaps.lua |
| `[b` | `<cmd>bprevious<CR>` | Previous buffer | keymaps.lua |
| `]q` | `<cmd>cnext<CR>` | Next quickfix item | keymaps.lua |
| `[q` | `<cmd>cprev<CR>` | Previous quickfix item | keymaps.lua |
| `]<Space>` | `o<Esc>` | Add blank line below | keymaps.lua |
| `[<Space>` | `O<Esc>` | Add blank line above | keymaps.lua |
| `]g` | `gs.next_hunk()` | Next git change | gitsigns.lua |
| `[g` | `gs.prev_hunk()` | Previous git change | gitsigns.lua |
| `]p` | `}` | Next paragraph | keymaps.lua |
| `[p` | `{` | Previous paragraph | keymaps.lua |
| `]f` | Next function start | Next function | treesitter-textobjects.lua |
| `[f` | Prev function start | Previous function | treesitter-textobjects.lua |
| `]F` | Next function end | Next function end | treesitter-textobjects.lua |
| `[F` | Prev function end | Previous function end | treesitter-textobjects.lua |
| `]t` | Next class start | Next class | treesitter-textobjects.lua |
| `[t` | Prev class start | Previous class | treesitter-textobjects.lua |
| `]a` | Next argument | Next argument | treesitter-textobjects.lua |
| `[a` | Prev argument | Previous argument | treesitter-textobjects.lua |
| `]c` | Next comment | Next comment | treesitter-textobjects.lua |
| `[c` | Prev comment | Previous comment | treesitter-textobjects.lua |

---

## Insert Mode

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `<C-s>` | `<cmd>w<CR><Esc>` | Save file | keymaps.lua |
| `<C-w>` | `<C-w>` | Delete word backward | keymaps.lua |
| `<A-BS>` | `<C-w>` | Delete word backward | keymaps.lua |
| `<A-d>` | `<C-o>dw` | Delete word forward | keymaps.lua |
| `<C-u>` | `<C-u>` | Delete to line start | keymaps.lua |
| `<C-k>` | `<C-o>D` | Delete to line end | keymaps.lua |

---

## Visual Mode / Select Mode

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `x` | `j` | Extend selection down | keymaps.lua |
| `X` | `V` | Convert to linewise selection | keymaps.lua |
| `<A-x>` | `V` | Shrink to line bounds (linewise) | keymaps.lua |
| `d` | `"_d` | Delete selection (no yank) | keymaps.lua |
| `c` | `"_c` | Change selection (no yank) | keymaps.lua |
| `r` | (function) | Replace selection with char | keymaps.lua |
| `C` | `yPgv` | Duplicate selection | keymaps.lua |
| `R` | `"_d"0P` | Replace selection with yanked | keymaps.lua |
| `` ` `` | `u` | Lowercase selection | keymaps.lua |
| `` <A-`> `` | `U` | Uppercase selection | keymaps.lua |
| `\|` | `:!` | Pipe selection through shell | keymaps.lua |
| `mm` | `%` | Jump to matching bracket | keymaps.lua |
| `<` | `<gv` | Indent left (stay in visual) | keymaps.lua |
| `>` | `>gv` | Indent right (stay in visual) | keymaps.lua |
| `<C-S-j>` | `:m '>+1<CR>gv=gv` | Move selection down | keymaps.lua |
| `<C-S-k>` | `:m '<-2<CR>gv=gv` | Move selection up | keymaps.lua |
| `p` | `"_dP` | Paste over selection (no yank) | keymaps.lua |
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
| `<C-Space>` | Complete | Trigger completion | nvim-cmp.lua |
| `<CR>` | Confirm | Confirm selection | nvim-cmp.lua |
| `<C-y>` | Confirm | Confirm selection | nvim-cmp.lua |
| `<S-CR>` | Confirm replace | Confirm with replace | nvim-cmp.lua |
| `<C-CR>` | Abort | Abort completion | nvim-cmp.lua |
| `<Tab>` | Select next | Next completion | nvim-cmp.lua |
| `<S-Tab>` | Select prev | Previous completion | nvim-cmp.lua |

**Note:** `<C-p>` removed to avoid conflict with Zellij pane mode. Use `<S-Tab>` or up arrow instead.

---

## LSP Keymaps

| Key | Action | Description | Source |
|-----|--------|-------------|--------|
| `K` | `vim.lsp.buf.hover` | Show hover docs | lspconfig.lua |
| `<C-k>` | `vim.lsp.buf.signature_help` | Signature help | lspconfig.lua |
| `gl` | `vim.diagnostic.open_float` | Show line diagnostics | lspconfig.lua |

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
| `!` | `:r!` | Insert shell command output | keymaps.lua |
| `\|` (visual) | `:!` | Pipe selection through shell | keymaps.lua |

---

## Implemented Helix Keymaps Summary

### Normal Mode - ✅ Implemented
- `%` - Select entire buffer (Helix style, matchit disabled)
- `U` - Redo (Helix style)
- `Q` - Record macro (swapped with q)
- `q` - Replay macro (swapped with Q)
- `C` - Duplicate line down
- `R` - Replace char with yanked text
- `` ` `` - Lowercase char
- `` <A-`> `` - Uppercase char
- `~` - Switch case (vim default, matches Helix)
- `<A-d>` - Delete motion without yanking
- `<A-c>` - Change motion without yanking
- `d` - Delete char under cursor (no yank)
- `c` - Change char under cursor (no yank)

### Goto Mode (g prefix) - ✅ Implemented
- `ga` - Go to alternate file
- `gt` - Go to window top
- `gm` - Go to window middle
- `gb` - Go to window bottom
- `g.` - Go to last modification
- Visual/operator-pending mode variants

### Match Mode (m prefix) - ✅ Implemented
- `mm` - Jump to matching bracket (preserves Vim's `%`)
- `ms` - Surround add (mini.surround)
- `mr` - Surround replace (mini.surround)
- `md` - Surround delete (mini.surround)
- `ma` - Select around textobject
- `mi` - Select inner textobject

### View Mode (z prefix) - ✅ Implemented
- `zc` - Center cursor
- `zm` - Center cursor (middle)
- `zj` - Scroll view down
- `zk` - Scroll view up

### Unimpaired - ✅ Implemented
- `]p` / `[p` - Next/previous paragraph
- `]f` / `[f` - Next/previous function
- `]t` / `[t` - Next/previous class
- `]a` / `[a` - Next/previous argument
- `]c` / `[c` - Next/previous comment
- `;` / `,` - Repeat last motion forward/backward

### Space Mode - ✅ Implemented
- `<leader>k` - Hover docs
- `<leader>'` - Resume last picker (telescope)
- `<leader>C` - Toggle block comments
- `<leader>R` - Replace from clipboard

### Visual/Select Mode - ✅ Implemented
- `d` - Delete selection without yanking
- `c` - Change selection without yanking
- `r` - Replace selection with single character
- `R` - Replace selection with yanked text
- `x` - Extend selection down
- `X` - Convert to linewise selection
- `<A-x>` - Shrink to line bounds

---

## Intentional Deviations from Helix

These are deliberate differences from Helix's default behavior:

1. **`;` and `,`** - Used for repeating treesitter text object motions when vim-visual-multi is NOT active. When VM is active, `,` is used for keep_primary_selection (Helix behavior). Added `<A-.>` as alias for Helix compatibility.

2. **`<C-k>` in insert mode** - Mapped to kill-to-line-end (Helix style). LSP signature help is available via LSP keymaps in normal mode.

3. **Surround enhancements** - mini.surround supports text objects in normal mode (e.g., `msiw(`) in addition to Helix's visual mode workflow. This is a feature enhancement.

4. **`s` and `S` implemented in vim-visual-multi** - These keys are now mapped to select_regex and split_selection when vim-visual-multi is active (started with `<C-n>`). They remain available for other uses when VM is not active.

5. **Case operators `` ` `` and `` <A-`> ``** - Enhanced to work on single character in normal mode with simplified implementation (`vul` and `vUl`).

6. **Normal mode `d` and `c`** - Modified to Helix style: delete/change single character under cursor without yanking. Use `<A-d>`/`<A-c>` with motions for Vim-style operator behavior without yanking.

7. **Multi-cursor implementation** - Helix has built-in multi-cursor support. We use vim-visual-multi plugin to achieve similar functionality. Start with `<C-n>` on a word, then use Helix-style keys (s, S, &, _, etc.) for selection manipulation.

8. **Matchit plugin disabled** - The matchit plugin is disabled via `vim.g.loaded_matchit = 1` to allow `%` to be used for select-all (Helix style). The original bracket-matching functionality is preserved via `mm`.

---

## Recent Changes (2025-12-28)

### Fixed `%` Select-All
- Disabled matchit plugin via `vim.g.loaded_matchit = 1` in init.lua
- This prevents matchit from overriding the `%` keymap
- Bracket matching functionality preserved via `mm`

### Simplified Keymap Implementations
- Replaced complex `feedkeys` calls with direct command strings
- `%` now uses `<cmd>normal! ggVG<CR>` instead of feedkeys
- Case transformations simplified to `vul` and `vUl`
- Change char mapping simplified to `"_xi`
- Better performance and more maintainable code

### Updated nvim-cmp
- Added `windwp/nvim-autopairs` to dependencies
- Removed `<C-p>` mapping (conflict with Zellij pane mode)
- Use `<S-Tab>` or up arrow for previous completion

### Enhanced nvim-autopairs
- Added safety check for `get_rules` to prevent errors
- Improved spacing rule with proper deletion behavior
- Added TypeScript to treesitter config

---

## Last Updated

**2025-12-28** - Fixed % select-all by disabling matchit, simplified keymap implementations, updated completion and autopairs configurations.
