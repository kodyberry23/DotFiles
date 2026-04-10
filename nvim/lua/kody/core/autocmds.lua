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
-- LSP IDLE MANAGEMENT
-- ============================================================================
-- Long-running LSP servers (especially vtsls/TypeScript and rust-analyzer)
-- accumulate memory over hours. Stop them after 5 minutes of lost focus,
-- cancel the stop if focus returns before the timer fires.

local lsp_idle_group = vim.api.nvim_create_augroup("LspIdleManagement", { clear = true })
local lsp_stop_timer = nil

vim.api.nvim_create_autocmd("FocusLost", {
  group = lsp_idle_group,
  desc = "Stop LSP servers after losing focus for 5 minutes",
  callback = function()
    if lsp_stop_timer then
      lsp_stop_timer:stop()
    end
    lsp_stop_timer = vim.defer_fn(function()
      local clients = vim.lsp.get_clients()
      if #clients > 0 then
        vim.notify(
          string.format("Stopping %d idle LSP server(s) to free memory", #clients),
          vim.log.levels.INFO
        )
        for _, client in pairs(clients) do
          client:stop()
        end
      end
    end, 1000 * 60 * 5) -- 5 minutes
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = lsp_idle_group,
  desc = "Cancel LSP stop timer when focus returns",
  callback = function()
    if lsp_stop_timer then
      lsp_stop_timer:stop()
      lsp_stop_timer = nil
    end
    vim.cmd("checktime")
  end,
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
