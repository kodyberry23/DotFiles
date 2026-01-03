return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- Provider configuration
    provider = "copilot", 
    auto_suggestions_provider = "copilot",
    
    -- ⭐ SYSTEM PROMPT: Concise coding assistant (NEW)
    system_prompt = [[You are a concise coding assistant.
Provide minimal, actionable code changes only.
Avoid explanations unless specifically requested.
Always read files before modifying.]],
    
    -- Provider-specific settings
    providers = {
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "claude-sonnet-4.5",
        timeout = 30000, 
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
    
    -- Behavior settings
    behaviour = {
      auto_suggestions = false, 
      auto_set_highlight_group = true, 
      auto_set_keymaps = true,
      
      -- CURSOR WORKFLOW SETTINGS:
      auto_apply_diff_after_generation = false,
      auto_approve_tool_permissions = true,
      
      support_paste_from_clipboard = false,
      minimize_diff = true, 
      enable_token_counting = false,
      auto_add_current_file = false, -- ⭐ DISABLED (was true, use @ to add manually)
    },
    
    -- Mappings configuration
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co", -- Choose Ours (Reject AI)
        theirs = "ct", -- Choose Theirs (Accept AI)
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        retry_user_request = "r",
        edit_user_request = "e",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "@",
        close = { "<Esc>", "q" },
      },
    },
    
    -- Hints configuration
    hints = { enabled = true },
    
    -- Windows configuration
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", 
      wrap = true, 
      width = 30, 
      sidebar_header = {
        align = "center", 
        rounded = true,
      },
    },
    
    selector = {
      provider = "telescope",
    },
    
    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
    },
  },
  
  -- Build configuration
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  
  -- Dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- Optional dependencies
    "nvim-tree/nvim-web-devicons", 
    "zbirenbaum/copilot.lua", 
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        file_types = { "markdown", "Avante" },
        render_modes = true, 
        anti_conceal = {
          enabled = true,
          above = 0,
          below = 0,
        },
        win_options = {
          conceallevel = {
            default = vim.api.nvim_get_option_value("conceallevel", {}),
            rendered = 2,
          },
          concealcursor = {
            default = vim.api.nvim_get_option_value("concealcursor", {}),
            rendered = "nc",
          },
        },
      },
    },
  },
  
  -- Key mappings
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "avante: ask",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "avante: refresh",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "avante: edit",
      mode = "v",
    },
  },
}