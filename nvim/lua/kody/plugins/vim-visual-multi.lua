return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    -- IMPORTANT: Must be set BEFORE plugin loads (in init, not config)
    -- This gives us Helix-style multi-cursor/multi-selection support

    -- Disable default mappings to avoid conflicts with our custom Helix-style bindings
    -- NOTE: When this is 0, the plugin creates <Plug> mappings but NOT the actual
    -- keybindings. We must manually create nmap/xmap to <Plug> in the config section.
    vim.g.VM_default_mappings = 0

    -- Set VM leader to backslash (avoid conflicts with space leader)
    vim.g.VM_leader = "\\"

    -- Initialize custom mappings table as Vim dictionary
    -- Must use vim.empty_dict() for proper Vim dictionary initialization
    vim.g.VM_maps = vim.empty_dict()

    -- ========================================================================
    -- CUSTOM MOTIONS FOR VM (Helix-style goto commands)
    -- ========================================================================
    -- Register custom motions so they work with multi-cursor
    -- Format: { "key" = "motion" } - the motion is executed at each cursor
    vim.g.VM_custom_motions = {
      ["gl"] = "$",      -- Go to line end
      ["gh"] = "0",      -- Go to line start
      ["gs"] = "^",      -- Go to first non-blank
      ["ge"] = "G",      -- Go to last line (file end)
    }

    -- ========================================================================
    -- CORE MULTI-CURSOR MAPPINGS (VM_maps configuration)
    -- ========================================================================
    -- NOTE: These VM_maps settings tell the plugin which keys to use for its
    -- BUFFER mappings (mappings created after VM starts). For PERMANENT mappings
    -- (like Add Cursor Down/Up), we must also create explicit nmap entries below
    -- because g:VM_default_mappings = 0 prevents automatic permanent mappings.

    -- Start multi-cursor on word under cursor (like Helix's multiple selections)
    vim.g.VM_maps["Find Under"] = "<C-n>" -- Select word, press n for next occurrence
    vim.g.VM_maps["Find Subword Under"] = "<C-n>" -- Works in visual mode too

    -- Add cursors vertically - these are configured here but ALSO need nmap below
    -- Helix-style: C - add cursor on next line, Alt-C - add cursor on previous line
    vim.g.VM_maps["Add Cursor Down"] = "C"
    vim.g.VM_maps["Add Cursor Up"] = "<A-C>"

    -- CRITICAL: Disable VM's default "C" buffer command (change to end of line)
    -- This conflicts with our "Add Cursor Down" = "C" mapping
    -- Without this, first C starts VM, but second C triggers "change to EOL"
    vim.g.VM_maps["C"] = ""

    -- ========================================================================
    -- HELIX SELECTION MANIPULATION MAPPINGS
    -- https://docs.helix-editor.com/keymap.html#selection-manipulation
    -- ========================================================================

    -- s - select_regex: Split selection by regex pattern
    vim.g.VM_maps["Start Regex Search"] = "s"

    -- S - split_selection: Split into separate selections
    vim.g.VM_maps["Split Regions"] = "S"

    -- Alt-minus - merge_selections: Merge all selections into one
    vim.g.VM_maps["Merge Regions"] = "<A-minus>"

    -- Alt-_ - merge_consecutive_selections: Merge consecutive selections
    -- Note: VM doesn't have a separate "Merge Consecutive" command
    -- Alt-_ will also trigger merge regions (same behavior)

    -- & - align_selections: Align selections
    vim.g.VM_maps["Align"] = "&"

    -- Alt-; - flip_selections: Reverse selection direction
    vim.g.VM_maps["Invert Direction"] = "<A-;>"

    -- ; - collapse_selection: Collapse selection to single cursor
    -- In Helix, ; collapses selection. In VM, this exits to normal mode with one cursor.
    vim.g.VM_maps["Toggle Single Region"] = ";"

    -- , - keep_primary_selection: Keep only the primary selection (alternative to ;)
    -- This keeps just the primary selection active in VM mode
    -- Note: In keymaps.lua, we'll handle , differently based on VM state

    -- Alt-, - remove_primary_selection: Remove the primary selection
    vim.g.VM_maps["Remove Last Region"] = "<A-,>"

    -- ( - rotate_selections_backward: Move to previous selection
    vim.g.VM_maps["Goto Prev"] = "("

    -- ) - rotate_selections_forward: Move to next selection
    vim.g.VM_maps["Goto Next"] = ")"

    -- Alt-( and Alt-) - rotate_selection_contents
    -- Note: VM's "Transpose" command cycles region contents, but doesn't have
    -- separate backward/forward. We'll create custom mappings in config section.

    -- Search (Helix style)
    -- * - Use selection as search pattern with word boundaries
    -- Note: VM's "Find All" command is triggered from visual mode or with Ctrl-n
    -- The * key in VM selects the word under cursor and finds all occurrences
    -- This is handled by the permanent mapping "Find Under" -> <C-n>

    -- Navigation between matches
    vim.g.VM_maps["Find Next"] = "n" -- Next occurrence (extends in visual mode)
    vim.g.VM_maps["Find Prev"] = "N" -- Previous occurrence
    vim.g.VM_maps["Skip Region"] = "q" -- Skip current and go to next
    vim.g.VM_maps["Remove Region"] = "Q" -- Remove current region

    -- ========================================================================
    -- ADDITIONAL VM FEATURES
    -- ========================================================================

    -- Undo/Redo with region restoration
    vim.g.VM_maps["Undo"] = "u"
    vim.g.VM_maps["Redo"] = "<C-r>"

    -- Find operator (m + motion to select all occurrences in range)
    vim.g.VM_maps["Find Operator"] = "m"

    -- Surround in VM mode
    vim.g.VM_maps["Surround"] = "ms" -- Use ms for surround in VM (avoid conflict)

    -- Replace pattern
    vim.g.VM_maps["Replace Pattern"] = "R"

    -- J - join_selections: Join lines inside selection
    -- Note: VM uses "J" by default in edit section (not a VM_maps configurable key)
    -- The default J behavior is preserved

    -- Ctrl-c - toggle_comments (handled by Comment.nvim when VM active)
    -- VM will pass through to Comment.nvim

    -- Tools and utilities (using VM leader \\)
    vim.g.VM_maps["Tools Menu"] = "\\`"
    vim.g.VM_maps["Case Setting"] = "\\c"
    vim.g.VM_maps["Toggle Whole Word"] = "\\w"
    vim.g.VM_maps["Align Char"] = "\\<"
    vim.g.VM_maps["Align Regex"] = "\\>"
    vim.g.VM_maps["Transpose"] = "\\t"
    vim.g.VM_maps["Duplicate"] = "\\d"

    -- Visual mode mappings (start VM from visual selection)
    vim.g.VM_maps["Visual Regex"] = "\\/"
    vim.g.VM_maps["Visual All"] = "\\A"
    vim.g.VM_maps["Visual Add"] = "\\a"
    vim.g.VM_maps["Visual Find"] = "\\f"
    vim.g.VM_maps["Visual Cursors"] = "\\c"

    -- ========================================================================
    -- SETTINGS
    -- ========================================================================

    -- Show statusline info
    vim.g.VM_show_warnings = 1

    -- Highlight settings
    vim.g.VM_highlight_matches = "underline"
  end,

  config = function()
    -- ========================================================================
    -- PERMANENT MAPPINGS (for starting VM)
    -- ========================================================================
    -- Since g:VM_default_mappings = 0, we must manually create the permanent
    -- mappings that start VM mode. The <Plug> mappings are always created by
    -- the plugin, but without explicit nmap entries, they're not accessible.

    -- C - Add cursor on next line (Helix: copy_selection_on_next_line)
    vim.keymap.set("n", "C", "<Plug>(VM-Add-Cursor-Down)", {
      desc = "VM: Add cursor down",
    })

    -- Alt-C - Add cursor on previous line (Helix: copy_selection_on_prev_line)
    vim.keymap.set("n", "<A-C>", "<Plug>(VM-Add-Cursor-Up)", {
      desc = "VM: Add cursor up",
    })

    -- Also map Ctrl-Down/Up as alternative (more discoverable)
    vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)", {
      desc = "VM: Add cursor down",
    })
    vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)", {
      desc = "VM: Add cursor up",
    })

    -- Visual mode: Create cursors from visual selection
    vim.keymap.set("x", "C", "<Plug>(VM-Visual-Cursors)", {
      desc = "VM: Create cursors from selection",
    })
    vim.keymap.set("x", "<A-C>", "<Plug>(VM-Visual-Cursors)", {
      desc = "VM: Create cursors from selection",
    })

    -- Ctrl-n permanent mapping (should work but let's be explicit)
    vim.keymap.set("n", "<C-n>", "<Plug>(VM-Find-Under)", {
      desc = "VM: Select word under cursor",
    })
    vim.keymap.set("x", "<C-n>", "<Plug>(VM-Find-Subword-Under)", {
      desc = "VM: Add selection as pattern",
    })

    -- ========================================================================
    -- CRITICAL: Override VM's buffer mappings when VM starts
    -- ========================================================================
    -- When VM starts, it creates buffer-local mappings that override our global
    -- mappings. We use autocmd to re-map C to "Add Cursor Down" after VM starts.
    -- The event "visual_multi_mappings" fires AFTER buffer mappings are applied.
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_mappings",
      callback = function()
        -- Override C to add cursor down instead of "change to end of line"
        vim.keymap.set("n", "C", "<Plug>(VM-Add-Cursor-Down)", {
          buffer = true,
          desc = "VM: Add cursor down",
        })
        vim.keymap.set("n", "<A-C>", "<Plug>(VM-Add-Cursor-Up)", {
          buffer = true,
          desc = "VM: Add cursor up",
        })
        vim.keymap.set("n", "<C-Down>", "<Plug>(VM-Add-Cursor-Down)", {
          buffer = true,
          desc = "VM: Add cursor down",
        })
        vim.keymap.set("n", "<C-Up>", "<Plug>(VM-Add-Cursor-Up)", {
          buffer = true,
          desc = "VM: Add cursor up",
        })
      end,
    })

    -- NOTE: We do NOT map 's' as a permanent mapping here because:
    -- 1. Vim's default 's' (substitute character) is useful
    -- 2. In Helix, 's' (select_regex) only makes sense when you have selections
    -- 3. The VM plugin handles 's' as a BUFFER mapping (only active when VM starts)
    -- To use regex search to START multi-cursor, use \\/ (backslash-slash)

    -- ========================================================================
    -- CUSTOM FUNCTIONS FOR HELIX FEATURES
    -- ========================================================================

    -- Helper to check if VM is active
    local function vm_active()
      return vim.fn.exists("*vm#is_active") == 1 and vim.fn["vm#is_active"]() == 1
    end

    -- Alt-* (visual mode): Use selection as exact search pattern (no word boundaries)
    -- This is Helix's "search_selection" command
    vim.keymap.set("v", "<A-*>", function()
      -- Get selected text and use as search pattern
      vim.cmd('normal! "vy')
      local pattern = vim.fn.getreg('v')
      -- Escape special regex characters for literal search
      pattern = vim.fn.escape(pattern, '\\/.*$^~[]')
      vim.fn.setreg('/', pattern)
      -- Start VM with this pattern
      vim.cmd([[call vm#commands#find_all(0, 0, ']] .. pattern .. [[', 1)]])
    end, { desc = "VM: Use selection as search pattern" })

    -- Alt-s: Split selections on newline (Helix: split_selection_on_newline)
    -- Note: VM doesn't have a direct split_by_regex function
    -- Use the Split Regions command with leader-s instead
    vim.keymap.set("n", "<A-s>", function()
      if vm_active() then
        -- Trigger the split regions plug which prompts for pattern
        vim.cmd([[call feedkeys("\<Plug>(VM-Split-Regions)")]])
      end
    end, { desc = "VM: Split regions" })

    -- _: Trim selections - remove leading/trailing whitespace (Helix: trim_selections)
    -- Note: This is tricky with VM. Using a workaround with run normal
    vim.keymap.set("n", "_", function()
      if vm_active() then
        -- Use the Run Normal plug which will apply to all regions
        vim.cmd([[call feedkeys("\<Plug>(VM-Run-Normal)")]])
        vim.fn.feedkeys("^", "n") -- Move to first non-whitespace
      end
    end, { desc = "VM: Go to first non-blank (like Helix _)" })

    -- K: Keep selections matching pattern (Helix: keep_selections)
    -- ✅ CORRECT: Helix uses uppercase K for "keep_selections"
    -- This is a filter operation - keep only selections matching a pattern
    vim.keymap.set("n", "K", function()
      if vm_active() then
        -- Use VM's filter regions command: 0=pattern, empty pattern, 1=prompt
        vim.cmd("call vm#special#commands#filter_regions(0, '', 1)")
      else
        -- When VM not active, use default K (hover)
        vim.lsp.buf.hover()
      end
    end, { desc = "VM: Keep selections / LSP Hover" })

    -- Alt-K: Remove selections matching pattern (Helix: remove_selections)
    -- ✅ CORRECT: Helix uses Alt-K for "remove_selections"
    vim.keymap.set("n", "<A-K>", function()
      if vm_active() then
        -- Use VM's filter regions command: 1=!pattern (remove matching), empty pattern, 1=prompt
        vim.cmd("call vm#special#commands#filter_regions(1, '', 1)")
      end
    end, { desc = "VM: Remove selections" })

    -- Alt-: Ensure selections are in forward direction (Helix: ensure_selections_forward)
    vim.keymap.set("n", "<A-:>", function()
      if vm_active() then
        -- Use reset_direction to make all regions face forward
        vim.cmd("call vm#commands#reset_direction(1)")
      end
    end, { desc = "VM: Ensure forward direction" })

    -- Alt-J: Join lines and select the inserted space (Helix: join_selections_space)
    vim.keymap.set("n", "<A-J>", function()
      if vm_active() then
        -- Use the Run Normal plug to execute J on all regions
        vim.cmd([[call feedkeys("\<Plug>(VM-Run-Normal)")]])
        vim.fn.feedkeys("J", "n")
      else
        -- When VM not active, regular join
        vim.cmd("normal! J")
      end
    end, { desc = "VM: Join with space / Join lines" })

    -- Alt-( / Alt-): Transpose/rotate selection contents
    -- VM's transpose cycles contents between all selections
    vim.keymap.set("n", "<A-(>", function()
      if vm_active() then
        vim.cmd([[call feedkeys("\<Plug>(VM-Transpose)")]])
      end
    end, { desc = "VM: Transpose contents" })
    vim.keymap.set("n", "<A-)>", function()
      if vm_active() then
        vim.cmd([[call feedkeys("\<Plug>(VM-Transpose)")]])
      end
    end, { desc = "VM: Transpose contents" })

    -- ========================================================================
    -- TREE-SITTER NAVIGATION (Helix-style)
    -- ========================================================================
    -- These use Neovim's built-in treesitter API to navigate syntax nodes.
    -- They work in normal/visual mode and when VM is active (on primary cursor).

    -- Helper: Get the treesitter node at cursor
    local function get_node_at_cursor()
      local ok, node = pcall(vim.treesitter.get_node)
      return ok and node or nil
    end

    -- Helper: Select a treesitter node (set visual selection to node range)
    local function select_node(node)
      if not node then return end
      local sr, sc, er, ec = node:range()
      -- Convert to 1-indexed
      sr, sc, er, ec = sr + 1, sc + 1, er + 1, ec
      -- Set visual selection
      vim.fn.setpos("'<", { 0, sr, sc, 0 })
      vim.fn.setpos("'>", { 0, er, ec, 0 })
      vim.cmd("normal! gv")
    end

    -- Helper: Move cursor to node start
    local function goto_node_start(node)
      if not node then return end
      local sr, sc = node:range()
      vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
    end

    -- Helper: Move cursor to node end
    local function goto_node_end(node)
      if not node then return end
      local _, _, er, ec = node:range()
      vim.api.nvim_win_set_cursor(0, { er + 1, math.max(0, ec - 1) })
    end

    -- Alt-o / Alt-Up: Expand selection to parent syntax node (Helix: expand_selection)
    local function expand_selection()
      local node = get_node_at_cursor()
      if not node then return end
      local parent = node:parent()
      if parent then
        select_node(parent)
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-o>", expand_selection, { desc = "TS: Expand to parent node" })

    -- Alt-i / Alt-Down: Shrink selection to first child node (Helix: shrink_selection)
    local function shrink_selection()
      local node = get_node_at_cursor()
      if not node then return end
      local child = node:child(0)
      if child then
        select_node(child)
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-i>", shrink_selection, { desc = "TS: Shrink to child node" })

    -- Alt-p / Alt-Left: Select previous sibling node (Helix: select_prev_sibling)
    local function select_prev_sibling()
      local node = get_node_at_cursor()
      if not node then return end
      local sibling = node:prev_sibling()
      if sibling then
        select_node(sibling)
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-p>", select_prev_sibling, { desc = "TS: Previous sibling" })

    -- Alt-n / Alt-Right: Select next sibling node (Helix: select_next_sibling)
    local function select_next_sibling()
      local node = get_node_at_cursor()
      if not node then return end
      local sibling = node:next_sibling()
      if sibling then
        select_node(sibling)
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-n>", select_next_sibling, { desc = "TS: Next sibling" })

    -- Alt-a: Select all sibling nodes (Helix: select_all_siblings)
    local function select_all_siblings()
      local node = get_node_at_cursor()
      if not node then return end
      local parent = node:parent()
      if not parent then return end
      -- Get first and last child of parent
      local first_child = parent:child(0)
      local last_child = parent:child(parent:child_count() - 1)
      if first_child and last_child then
        local sr, sc = first_child:range()
        local _, _, er, ec = last_child:range()
        vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
        vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
        vim.cmd("normal! gv")
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-a>", select_all_siblings, { desc = "TS: Select all siblings" })

    -- Alt-I / Alt-Shift-Down: Select all children nodes (Helix: select_all_children)
    local function select_all_children()
      local node = get_node_at_cursor()
      if not node or node:child_count() == 0 then return end
      local first_child = node:child(0)
      local last_child = node:child(node:child_count() - 1)
      if first_child and last_child then
        local sr, sc = first_child:range()
        local _, _, er, ec = last_child:range()
        vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
        vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
        vim.cmd("normal! gv")
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-I>", select_all_children, { desc = "TS: Select all children" })

    -- Alt-e: Move to end of parent node (Helix: move_parent_node_end)
    local function move_parent_end()
      local node = get_node_at_cursor()
      if not node then return end
      local parent = node:parent()
      if parent then
        goto_node_end(parent)
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-e>", move_parent_end, { desc = "TS: Go to parent node end" })

    -- Alt-b: Move to start of parent node (Helix: move_parent_node_start)
    local function move_parent_start()
      local node = get_node_at_cursor()
      if not node then return end
      local parent = node:parent()
      if parent then
        goto_node_start(parent)
      end
    end
    vim.keymap.set({ "n", "x" }, "<A-b>", move_parent_start, { desc = "TS: Go to parent node start" })

    -- ========================================================================
    -- HELIX MULTI-CURSOR WORKFLOW IMPLEMENTATION
    -- ========================================================================
    --
    -- Workflow:
    -- 1. START MULTI-CURSOR:
    --    - <C-n> on a word → select word, press again for next occurrence
    --    - * on word → search with word boundaries, adds all matches
    --    - C/Alt-C → add cursor below/above current line
    --    - % then s → select all regex matches in file
    --    - Visual select then \\f → find all matches of selection
    --
    -- 2. EXTEND SELECTIONS:
    --    - n/N → add next/previous occurrence to selections
    --    - v then move → extend all selections (like Helix select mode)
    --    - <Tab> → switch between cursor and extend mode
    --
    -- 3. MANIPULATE SELECTIONS:
    --    - s → select by regex inside selections
    --    - S → split selections on regex
    --    - Alt-s → split on newlines
    --    - & → align selections
    --    - _ → trim whitespace
    --    - J/Alt-J → join lines
    --
    -- 4. FILTER SELECTIONS:
    --    - K → keep only selections matching pattern
    --    - Alt-K → remove selections matching pattern
    --    - q → skip current selection
    --    - Q → remove current selection
    --
    -- 5. EXIT:
    --    - ; or Esc → collapse to single cursor / exit VM
    --    - , → keep only primary selection (in keymaps.lua)
    --
    -- Helix features implemented:
    -- ✅ C/Alt-C - copy_selection_on_next/prev_line (add cursor above/below)
    -- ✅ s - select_regex (select all regex matches inside selections)
    -- ✅ S - split_selection (split by regex)
    -- ✅ Alt-s - split_selection_on_newline
    -- ✅ Alt-minus - merge_selections
    -- ⚠️  Alt-_ - merge_consecutive_selections (uses same as Alt-minus)
    -- ✅ & - align_selections
    -- ✅ _ - trim_selections
    -- ✅ ; - collapse_selection (collapse to single cursor)
    -- ✅ Alt-; - flip_selections (reverse direction)
    -- ✅ Alt-: - ensure_selections_forward
    -- ✅ , - keep_primary_selection (handled in keymaps.lua with VM detection)
    -- ✅ Alt-, - remove_primary_selection
    -- ✅ ( - rotate_selections_backward (goto prev)
    -- ✅ ) - rotate_selections_forward (goto next)
    -- ⚠️  Alt-( - rotate_selection_contents (uses VM's Transpose)
    -- ⚠️  Alt-) - rotate_selection_contents (uses VM's Transpose)
    -- ✅ K - keep_selections (filter - keep matching)
    -- ✅ Alt-K - remove_selections (filter - remove matching)
    -- ✅ <C-n> - select word under cursor, find next occurrence
    -- ✅ Alt-* - search_selection (exact selection match)
    -- ✅ n - search_next / extend_search_next (context dependent)
    -- ✅ N - search_prev / extend_search_prev (context dependent)
    -- ✅ J - join_selections (default VM behavior)
    -- ✅ Alt-J - join_selections_space
    -- ✅ % - select_all (select entire file - in keymaps.lua)
    -- ✅ x - extend_line_below (select line - in keymaps.lua)
    -- ✅ X - extend_to_line_bounds (linewise - in keymaps.lua)
    -- ✅ Alt-x - shrink_to_line_bounds (in keymaps.lua)
    -- ✅ Ctrl-c - toggle_comments (via Comment.nvim integration)
    --
    -- ✅ TREE-SITTER NAVIGATION (implemented with nvim-treesitter):
    -- ✅ Alt-o/Alt-up - expand_selection (tree-sitter parent node)
    -- ✅ Alt-i/Alt-down - shrink_selection (tree-sitter child node)
    -- ✅ Alt-p/Alt-left - select_prev_sibling (tree-sitter)
    -- ✅ Alt-n/Alt-right - select_next_sibling (tree-sitter)
    -- ✅ Alt-a - select_all_siblings (tree-sitter)
    -- ✅ Alt-I/Alt-Shift-down - select_all_children (tree-sitter)
    -- ✅ Alt-e - move_parent_node_end (tree-sitter)
    -- ✅ Alt-b - move_parent_node_start (tree-sitter)
  end,
}
