return {
  "echasnovski/mini.surround",
  version = "*",
  event = "VeryLazy",
  opts = {
    -- Helix-style mappings using m prefix (match mode)
    -- ✅ VERIFIED: These mappings match Helix's surround behavior!
    --
    -- Helix workflow:
    --   1. Select text in visual mode (e.g., viw)
    --   2. Press ms followed by surround character (e.g., ms( or ms")
    --   3. For replace/delete, cursor can be anywhere inside: mr([  or  md(
    --
    -- mini.surround behavior:
    --   - Normal mode: ms + text object + char (e.g., msiw( = surround inner word)
    --   - Visual mode: Select first, then ms + char (e.g., viw then ms() ✅ MATCHES HELIX
    --   - Replace/Delete: mr<old><new> or md<char> from inside ✅ MATCHES HELIX
    --
    -- Bonus: mini.surround also supports text objects in normal mode, which is
    -- actually an enhancement over Helix (e.g., msiw( = surround inner word with parens)
    mappings = {
      add = "ms",            -- Add surrounding (helix: ms<char>)
      delete = "md",         -- Delete surrounding (helix: md<char>)
      find = "",             -- Find surrounding (disabled)
      find_left = "",        -- Find left surrounding (disabled)
      highlight = "",        -- Highlight surrounding (disabled)
      replace = "mr",        -- Replace surrounding (helix: mr<from><to>)
      update_n_lines = "",   -- Update `n_lines` (disabled)
    },
    -- Number of lines within which surrounding is searched
    n_lines = 50,
    -- Whether to respect selection type (charwise, linewise, blockwise)
    respect_selection_type = false,
    -- How to search for surrounding (default is 'cover')
    search_method = "cover",
    -- Silent mode (no messages)
    silent = false,
  },
}
