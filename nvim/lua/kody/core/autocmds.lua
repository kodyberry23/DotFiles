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
local lsp_stopped_servers = {}

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
        lsp_stopped_servers = {}
        for _, client in pairs(clients) do
          lsp_stopped_servers[client.name] = true
        end
        vim.notify(
          string.format("Stopping %d idle LSP server(s) to free memory", #clients),
          vim.log.levels.INFO
        )
        -- Use vim.lsp.enable(name, false) to properly disable servers.
        -- client:stop() only kills the process but leaves the server
        -- marked as "enabled", preventing restart on FocusGained.
        for name in pairs(lsp_stopped_servers) do
          vim.lsp.enable(name, false)
        end
      end
    end, 1000 * 60 * 5) -- 5 minutes
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = lsp_idle_group,
  desc = "Cancel LSP stop timer or restart stopped servers when focus returns",
  callback = function()
    if lsp_stop_timer then
      lsp_stop_timer:stop()
      lsp_stop_timer = nil
    end
    vim.cmd("checktime")
    -- Re-enable servers that were disabled by the idle timer.
    -- vim.lsp.enable() alone doesn't trigger starts on existing buffers,
    -- so doautoall FileType is needed to kick the FileType callback.
    if next(lsp_stopped_servers) then
      local servers = vim.tbl_keys(lsp_stopped_servers)
      lsp_stopped_servers = {}
      vim.lsp.enable(servers)
      vim.cmd("doautoall FileType")
    end
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
