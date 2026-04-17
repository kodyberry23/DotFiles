-- ============================================================================
-- LSP CLEANUP ON EXIT
-- ============================================================================
-- When the terminal is closed (SIGHUP), Neovim's built-in VimLeavePre handler
-- tries to gracefully stop LSP servers with a timeout, but during a signal-
-- triggered exit the event loop may not complete the wait. This leaves LSP
-- server processes (vtsls, rust-analyzer, etc.) orphaned and leaking memory.
--
-- This handler force-kills all LSP clients immediately on exit, ensuring
-- their OS processes are terminated even during SIGHUP.

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("ForceLspCleanup", { clear = true }),
  desc = "Force-kill all LSP clients to prevent orphaned processes",
  callback = function()
    local clients = vim.lsp.get_clients()
    for _, client in pairs(clients) do
      client:stop(true) -- true = force kill (SIGKILL), no graceful timeout
    end
  end,
})

-- ============================================================================
-- FOCUS
-- ============================================================================

vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("Checktime", { clear = true }),
  desc = "Re-read files changed outside of Neovim",
  command = "checktime",
})

-- ============================================================================
-- FILETYPE OVERRIDES
-- ============================================================================

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  desc = "Disable concealing in JSON files (show quotes)",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
