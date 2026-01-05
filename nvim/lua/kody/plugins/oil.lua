return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "refractalize/oil-git-status.nvim",
    "JezerM/oil-lsp-diagnostics.nvim",
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Disable default keymaps to avoid conflicts with Yazi-style bindings
      use_default_keymaps = false,
      keymaps = {
        -- Help
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<F1>"] = { "actions.show_help", mode = "n" },

        -- Navigation (use Enter to select, - to go up)
        ["<CR>"] = { "actions.select", mode = "n" },
        ["<Left>"] = { "actions.parent", mode = "n" },
        ["<Right>"] = { "actions.select", mode = "n" },
        ["-"] = { "actions.parent", mode = "n" },
        ["<Backspace>"] = { "actions.parent", mode = "n" },

        -- Open in splits/tabs
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, mode = "n" },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, mode = "n" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, mode = "n" },

        -- Close/Quit (Yazi style: q=quit)
        ["q"] = { "actions.close", mode = "n" },
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<Esc>"] = { "actions.close", mode = "n" },

        -- Toggle hidden files (Yazi style: .=toggle hidden)
        ["."] = { "actions.toggle_hidden", mode = "n" },

        -- Preview
        ["<Tab>"] = { "actions.preview", mode = "n" },
        ["<C-p>"] = { "actions.preview", mode = "n" },

        -- Refresh
        ["<C-l>"] = { "actions.refresh", mode = "n" },
        ["<C-r>"] = { "actions.refresh", mode = "n" },

        -- Yank/Copy path (Yazi style: y=yank, cc=copy path)
        ["y"] = { "actions.copy_entry_path", mode = "n" },
        ["Y"] = {
          desc = "Copy absolute path",
          callback = function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then return end
            local full_path = dir .. entry.name
            vim.fn.setreg("+", full_path)
            vim.fn.setreg('"', full_path)
            vim.notify("Copied: " .. full_path, vim.log.levels.INFO)
          end,
          mode = "n",
        },

        -- Open external (Yazi style: o=open)
        ["o"] = { "actions.open_external", mode = "n" },

        -- Sorting (Yazi style: ,s=sort)
        ["gs"] = { "actions.change_sort", mode = "n" },

        -- Go to CWD
        ["_"] = { "actions.open_cwd", mode = "n" },

        -- cd commands
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },

        -- Trash toggle
        ["g\\"] = { "actions.toggle_trash", mode = "n" },

        -- Selection toggle (Yazi style: <Space>=toggle selection)
        ["<Space>"] = {
          desc = "Toggle selection",
          callback = function()
            local oil = require("oil")
            -- Move to next line after toggle (like Yazi)
            vim.cmd("normal! j")
          end,
          mode = "n",
        },

        -- Toggle detail view
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            local oil = require("oil")
            local config = require("oil.config")
            if #config.columns == 1 then
              oil.set_columns({ "icon", "permissions", "size", "mtime" })
            else
              oil.set_columns({ "icon" })
            end
          end,
          mode = "n",
        },
      },
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        natural_order = "fast",
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      win_options = {
        signcolumn = "yes:2",
      },
      -- Skip confirmation for simple operations
      skip_confirm_for_simple_edits = true,
      -- Send deleted files to trash
      delete_to_trash = true,
      -- Watch for external changes
      watch_for_changes = true,
    })

    -- Load extensions
    require("oil-git-status").setup({
      show_ignored = false,
    })

    require("oil-lsp-diagnostics").setup({
      show_signs = true,
    })
  end,
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    { "<leader>-", "<cmd>Oil --float<cr>", desc = "Open Oil in float" },
  },
}
