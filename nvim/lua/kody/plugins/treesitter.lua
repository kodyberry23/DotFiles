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

    -- Start treesitter on matching filetypes. If the parser isn't installed
    -- yet (install() above is async — can race on first launch or silently
    -- fail), install it on demand and start() once it's ready. Without this
    -- retry, opening a file whose parser didn't finish downloading requires
    -- a manual :TSInstall.
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

        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft

        if vim.treesitter.language.add(lang) then
          vim.treesitter.start(args.buf, lang)
          return
        end

        -- Parser missing — kick off an install and start once ready.
        require("nvim-treesitter").install({ lang }):await(function()
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf)
              and vim.treesitter.language.add(lang)
            then
              vim.treesitter.start(args.buf, lang)
            end
          end)
        end)
      end,
      desc = "Enable treesitter highlighting; install parser on demand",
    })
  end,
}
