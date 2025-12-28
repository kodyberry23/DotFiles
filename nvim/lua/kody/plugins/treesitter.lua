return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
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

    -- Enable treesitter highlighting for all supported filetypes
    -- The new nvim-treesitter API requires explicit activation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "vim", "vimdoc", "query",
        "elixir", "heex", "eelixir",
        "lua", "javascript", "typescript", "python",
        "rust", "go", "bash", "sh", "html", "css",
        "json", "yaml", "markdown",
      },
      callback = function()
        vim.treesitter.start()
      end,
      desc = "Enable treesitter highlighting",
    })
  end,
}
