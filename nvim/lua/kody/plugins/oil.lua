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
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["l"] = "actions.select", -- Yazi style enter
        ["h"] = "actions.parent", -- Yazi style leave
        ["q"] = "actions.close",
        ["<C-c>"] = "actions.close",
        ["r"] = {
          desc = "Rename",
          callback = function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then return end
            
            vim.ui.input({ prompt = "Rename: ", default = entry.name }, function(new_name)
              if not new_name or new_name == entry.name then return end
              local old_path = dir .. entry.name
              local new_path = dir .. new_name
              
              -- Rename using libuv
              vim.loop.fs_rename(old_path, new_path, function(err)
                if err then
                  vim.schedule(function()
                    vim.notify("Rename failed: " .. err, vim.log.levels.ERROR)
                  end)
                else
                  vim.schedule(function()
                    oil.refresh()
                  end)
                end
              end)
            end)
          end,
        },
        ["."] = "actions.toggle_hidden", -- Yazi style toggle hidden
        ["<leader>r"] = "actions.refresh",
        ["y"] = "actions.copy_entry_path", -- Copy path
        ["<leader>y"] = "actions.copy_entry_path",
        ["a"] = {
          desc = "Create new file/dir",
          callback = function()
            local oil = require("oil")
            local cwd = oil.get_current_dir()
            vim.ui.input({ prompt = "Create (end with / for dir): " }, function(name)
              if not name or name == "" then return end
              local path = cwd .. name
              if name:match("/$") then
                vim.fn.mkdir(path, "p")
              else
                local f = io.open(path, "w")
                if f then f:close() end
              end
              vim.schedule(function()
                oil.refresh()
              end)
            end)
          end,
        },
        -- ["<C-p>"] = "actions.preview",
        -- ["<C-l>"] = "actions.refresh",
        -- ["-"] = "actions.parent",
        -- ["_"] = "actions.open_cwd",
        -- ["`"] = "actions.cd",
        -- ["~"] = "actions.tcd",
        -- ["gs"] = "actions.change_sort",
        -- ["gx"] = "actions.open_external",
        -- ["g."] = "actions.toggle_hidden",
        -- ["g\\"] = "actions.toggle_trash",
      },
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
      },
      win_options = {
        signcolumn = "yes:2",
      },
    })

    -- Load extensions
    require("oil-git-status").setup({
      show_ignored = false, -- show ignored files in git status
    })
    
    require("oil-lsp-diagnostics").setup({
      show_signs = true, -- show diagnostic signs
    })
  end,
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
}
