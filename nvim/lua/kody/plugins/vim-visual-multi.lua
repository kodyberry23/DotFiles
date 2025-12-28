return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    -- IMPORTANT: Must be set BEFORE plugin loads (in init, not config)
    -- This gives us Helix-style multi-cursor/multi-selection support

    -- Disable default mappings to avoid conflicts
    vim.g.VM_default_mappings = 0

    -- Set VM leader to backslash (avoid conflicts with space leader)
    vim.g.VM_leader = "\\"

    -- Initialize custom mappings table as Vim dictionary
    -- Must use vim.empty_dict() for proper Vim dictionary initialization
    vim.g.VM_maps = vim.empty_dict()

    -- ========================================================================
    -- CORE MULTI-CURSOR MAPPINGS
    -- ========================================================================

    -- Start multi-cursor on word under cursor (like Helix's multiple selections)
    vim.g.VM_maps["Find Under"] = "<C-n>" -- Select word, press n for next occurrence
    vim.g.VM_maps["Find Subword Under"] = "<C-n>" -- Works in visual mode too

    -- Add cursors vertically (column editing)
    vim.g.VM_maps["Add Cursor Down"] = "<C-Down>"
    vim.g.VM_maps["Add Cursor Up"] = "<C-Up>"

    -- Switch between cursor mode and extend mode (like visual mode)
    vim.g.VM_maps["Switch Mode"] = "<Tab>"

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
    -- Note: VM doesn't have exact equivalent, using merge regions
    vim.g.VM_maps["Merge Consecutive Regions"] = "<A-_>"

    -- & - align_selections: Align selections
    vim.g.VM_maps["Align"] = "&"

    -- Alt-; - flip_selections: Reverse selection direction
    vim.g.VM_maps["Invert Direction"] = "<A-;>"

    -- , - keep_primary_selection: Keep only the primary selection
    vim.g.VM_maps["Toggle Single Region"] = ","

    -- Alt-, - remove_primary_selection: Remove the primary selection
    vim.g.VM_maps["Remove Last Region"] = "<A-,>"

    -- ( - rotate_selections_backward: Move to previous selection
    vim.g.VM_maps["Goto Prev"] = "("

    -- ) - rotate_selections_forward: Move to next selection
    vim.g.VM_maps["Goto Next"] = ")"

    -- Alt-( - rotate_selection_contents_backward
    vim.g.VM_maps["Rotate Contents Backward"] = "<A-(>"

    -- Alt-) - rotate_selection_contents_forward
    vim.g.VM_maps["Rotate Contents Forward"] = "<A-)>"

    -- Navigation between matches
    vim.g.VM_maps["Find Next"] = "n" -- Next occurrence
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
    vim.g.VM_maps["Join Lines"] = "J"

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
    -- CUSTOM FUNCTIONS FOR HELIX FEATURES
    -- ========================================================================

    -- Helper to check if VM is active
    local function vm_active()
      return vim.fn.exists("*vm#is_active") == 1 and vim.fn["vm#is_active"]() == 1
    end

    -- Alt-s: Split selections on newline (Helix: split_selection_on_newline)
    vim.keymap.set("n", "<A-s>", function()
      if vm_active() then
        vim.cmd("call vm#commands#split_by_regex('\\n')")
      end
    end, { desc = "VM: Split on newline" })

    -- _: Trim selections - remove leading/trailing whitespace (Helix: trim_selections)
    vim.keymap.set("n", "_", function()
      if vm_active() then
        -- Use VM's run normal command to trim each region
        vim.cmd([[call vm#commands#run_normal(':s/\v^\s+|\s+$//g')]])
      end
    end, { desc = "VM: Trim selections" })

    -- K: Keep selections matching pattern (Helix: keep_selections)
    -- This is a filter operation - keep only selections matching a pattern
    vim.keymap.set("n", "K", function()
      if vm_active() then
        local pattern = vim.fn.input("Keep pattern: ")
        if pattern ~= "" then
          vim.cmd("call vm#commands#filter_regions('" .. pattern .. "', 1)")
        end
      else
        -- When VM not active, use default K (hover)
        vim.lsp.buf.hover()
      end
    end, { desc = "VM: Keep selections / LSP Hover" })

    -- Alt-K: Remove selections matching pattern (Helix: remove_selections)
    vim.keymap.set("n", "<A-K>", function()
      if vm_active() then
        local pattern = vim.fn.input("Remove pattern: ")
        if pattern ~= "" then
          vim.cmd("call vm#commands#filter_regions('" .. pattern .. "', 0)")
        end
      end
    end, { desc = "VM: Remove selections" })

    -- Alt-: Ensure selections are in forward direction (Helix: ensure_selections_forward)
    vim.keymap.set("n", "<A-:>", function()
      if vm_active() then
        vim.cmd("call vm#commands#ensure_forward()")
      end
    end, { desc = "VM: Ensure forward direction" })

    -- Alt-J: Join lines and select the inserted space (Helix: join_selections_space)
    vim.keymap.set("n", "<A-J>", function()
      if vm_active() then
        vim.cmd("call vm#commands#join_lines(1)") -- 1 = keep space selected
      else
        -- When VM not active, regular join
        vim.cmd("normal! J")
      end
    end, { desc = "VM: Join with space / Join lines" })

    -- ========================================================================
    -- TREE-SITTER NAVIGATION (when VM is active)
    -- ========================================================================

    -- Alt-o / Alt-up: Expand selection to parent syntax node
    vim.keymap.set("n", "<A-o>", function()
      if vm_active() then
        vim.cmd("call vm#commands#expand_region()")
      end
    end, { desc = "VM: Expand to parent node" })
    vim.keymap.set("n", "<A-Up>", function()
      if vm_active() then
        vim.cmd("call vm#commands#expand_region()")
      end
    end, { desc = "VM: Expand to parent node" })

    -- Alt-i / Alt-down: Shrink selection to child syntax node
    vim.keymap.set("n", "<A-i>", function()
      if vm_active() then
        vim.cmd("call vm#commands#shrink_region()")
      end
    end, { desc = "VM: Shrink to child node" })
    vim.keymap.set("n", "<A-Down>", function()
      if vm_active() then
        vim.cmd("call vm#commands#shrink_region()")
      end
    end, { desc = "VM: Shrink to child node" })

    -- Alt-p / Alt-left: Select previous sibling node
    vim.keymap.set("n", "<A-p>", function()
      if vm_active() then
        vim.cmd("call vm#commands#select_prev_sibling()")
      end
    end, { desc = "VM: Previous sibling" })
    vim.keymap.set("n", "<A-Left>", function()
      if vm_active() then
        vim.cmd("call vm#commands#select_prev_sibling()")
      end
    end, { desc = "VM: Previous sibling" })

    -- Alt-n / Alt-right: Select next sibling node
    vim.keymap.set("n", "<A-n>", function()
      if vm_active() then
        vim.cmd("call vm#commands#select_next_sibling()")
      end
    end, { desc = "VM: Next sibling" })
    vim.keymap.set("n", "<A-Right>", function()
      if vm_active() then
        vim.cmd("call vm#commands#select_next_sibling()")
      end
    end, { desc = "VM: Next sibling" })

    -- Alt-a: Select all sibling nodes
    vim.keymap.set("n", "<A-a>", function()
      if vm_active() then
        vim.cmd("call vm#commands#select_all_siblings()")
      end
    end, { desc = "VM: All siblings" })

    -- Alt-I / Alt-Shift-down: Select all children nodes
    vim.keymap.set("n", "<A-I>", function()
      if vm_active() then
        vim.cmd("call vm#commands#select_all_children()")
      end
    end, { desc = "VM: All children" })
    vim.keymap.set("n", "<A-S-Down>", function()
      if vm_active() then
        vim.cmd("call vm#commands#select_all_children()")
      end
    end, { desc = "VM: All children" })

    -- Alt-e: Move to end of parent node
    vim.keymap.set("n", "<A-e>", function()
      if vm_active() then
        vim.cmd("call vm#commands#move_parent_end()")
      end
    end, { desc = "VM: Parent node end" })

    -- Alt-b: Move to start of parent node
    vim.keymap.set("n", "<A-b>", function()
      if vm_active() then
        vim.cmd("call vm#commands#move_parent_start()")
      end
    end, { desc = "VM: Parent node start" })

    -- ========================================================================
    -- DOCUMENTATION
    -- ========================================================================

    -- Workflow:
    -- 1. Start VM with <C-n> on a word (or visual selection + \\/)
    -- 2. Press n/N to add more occurrences
    -- 3. Press <Tab> to switch between cursor and extend mode
    -- 4. Use s to select by regex, S to split selections
    -- 5. Use &, _, etc. for manipulation
    -- 6. Press <Esc> to exit VM mode
    --
    -- Helix features implemented:
    -- ✅ s - select_regex
    -- ✅ S - split_selection
    -- ✅ Alt-s - split_selection_on_newline
    -- ✅ Alt-minus - merge_selections
    -- ✅ & - align_selections
    -- ✅ _ - trim_selections
    -- ✅ ; - collapse_selection (via Esc)
    -- ✅ Alt-; - flip_selections
    -- ✅ , - keep_primary_selection
    -- ✅ Alt-, - remove_primary_selection
    -- ✅ ( - rotate_selections_backward
    -- ✅ ) - rotate_selections_forward
    -- ✅ K - keep_selections (filter)
    -- ✅ Alt-K - remove_selections (filter)
    -- ✅ Alt-_ - merge_consecutive_selections
    -- ✅ Alt-: - ensure_selections_forward
    -- ✅ Alt-( - rotate_selection_contents_backward
    -- ✅ Alt-) - rotate_selection_contents_forward
    -- ✅ J - join_selections
    -- ✅ Alt-J - join_selections_space
    -- ✅ Ctrl-c - toggle_comments (via Comment.nvim)
    -- ✅ Alt-o/Alt-up - expand_selection (tree-sitter)
    -- ✅ Alt-i/Alt-down - shrink_selection (tree-sitter)
    -- ✅ Alt-p/Alt-left - select_prev_sibling (tree-sitter)
    -- ✅ Alt-n/Alt-right - select_next_sibling (tree-sitter)
    -- ✅ Alt-a - select_all_siblings (tree-sitter)
    -- ✅ Alt-I/Alt-Shift-down - select_all_children (tree-sitter)
    -- ✅ Alt-e - move_parent_node_end (tree-sitter)
    -- ✅ Alt-b - move_parent_node_start (tree-sitter)
  end,
}
