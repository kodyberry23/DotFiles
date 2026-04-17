-- Force-kill LSP clients on exit. Neovim's built-in shutdown waits for a
-- graceful stop that may not complete during a SIGHUP exit (terminal closed),
-- which leaves vtsls/rust-analyzer/etc. orphaned and leaking memory.
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("ForceLspCleanup", { clear = true }),
  desc = "Force-kill all LSP clients to prevent orphaned processes",
  callback = function()
    for _, client in pairs(vim.lsp.get_clients()) do
      client:stop(true) -- true = SIGKILL, no graceful timeout
    end
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("Checktime", { clear = true }),
  desc = "Re-read files changed outside of Neovim",
  command = "checktime",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  desc = "Disable concealing in JSON files (show quotes)",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
