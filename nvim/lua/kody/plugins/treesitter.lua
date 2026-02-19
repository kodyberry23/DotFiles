return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- CRITICAL: Register markdown parser for Avante filetype
    -- This allows render-markdown.nvim to work with Avante buffers
    vim.treesitter.language.register("markdown", "Avante")

    -- Setup nvim-treesitter (new API - no more configs module)
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Install parsers
    require("nvim-treesitter").install({
      "vim", "vimdoc", "query",
      -- Elixir ecosystem
      "elixir", "heex", "eex", "erlang",
      -- Other languages
      "lua", "javascript", "typescript", "python",
      "rust", "go", "bash", "html", "css",
      "json", "yaml", "markdown", "markdown_inline",
    })

    -- Enable treesitter highlighting via FileType autocmd (new API)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "vim", "vimdoc", "query",
        "elixir", "heex", "eelixir",
        "lua", "javascript", "typescript", "python",
        "rust", "go", "bash", "sh", "html", "css",
        "json", "yaml", "markdown",
        "Avante",
      },
      callback = function(args)
        -- Skip treesitter for large files (>100KB)
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > 100 * 1024 then
          return
        end
        vim.treesitter.start()
        -- Enable treesitter-based indentation (experimental)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
      desc = "Enable treesitter highlighting and indentation",
    })
  end,
}
