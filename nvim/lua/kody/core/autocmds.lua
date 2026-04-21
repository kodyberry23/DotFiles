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

-- mise-aware LSP lifecycle: bounce an LSP client when the buffer's mise
-- root no longer matches the one it was spawned under. Without this, vtsls
-- and friends keep using the previous project's Node/Elixir/OTP across a
-- project switch in the same Neovim session.
local mise_markers = { "mise.toml", ".mise.toml", ".mise/config.toml", ".tool-versions" }
local spawn_root = {} -- client_id -> mise root at spawn time
local mise_group = vim.api.nvim_create_augroup("MiseLspLifecycle", { clear = true })

local function mise_root(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then return nil end
  local hit = vim.fs.find(mise_markers, { upward = true, path = path, type = "file" })[1]
  return hit and vim.fs.dirname(hit) or nil
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = mise_group,
  callback = function(ev) spawn_root[ev.data.client_id] = mise_root(ev.buf) end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
  group = mise_group,
  callback = function(ev)
    local root = mise_root(ev.buf)
    if not root then return end
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = ev.buf })) do
      if spawn_root[c.id] and spawn_root[c.id] ~= root then
        vim.notify(("[mise] %s: %s -> %s, restarting"):format(c.name, spawn_root[c.id], root))
        spawn_root[c.id] = nil
        c:stop() -- auto-reattaches via vim.lsp.enable() on next buffer event
      end
    end
  end,
})

vim.api.nvim_create_user_command("MiseLspStatus", function()
  local lines = { "── Attached LSP clients ──" }
  for _, c in ipairs(vim.lsp.get_clients()) do
    lines[#lines + 1] = ("  %s  mise_root=%s  root_dir=%s")
      :format(c.name, spawn_root[c.id] or "-", c.config.root_dir or "-")
  end
  if #lines == 1 then lines[2] = "  (none)" end

  lines[#lines + 1] = ""
  lines[#lines + 1] = "── exepath from Neovim PATH ──"
  for _, t in ipairs({ "node", "npm", "elixir", "mix", "erl", "go", "python3" }) do
    local p = vim.fn.exepath(t)
    lines[#lines + 1] = ("  %-8s %s"):format(t, p ~= "" and p or "(not found)")
  end

  lines[#lines + 1] = ""
  lines[#lines + 1] = "── PATH head ──"
  local path = vim.split(vim.env.PATH or "", ":", { plain = true })
  for i = 1, math.min(8, #path) do lines[#lines + 1] = "  " .. path[i] end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "miselspstatus"
  vim.api.nvim_buf_set_name(buf, "MiseLspStatus")
  vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
  vim.cmd("botright " .. math.min(#lines + 2, 20) .. "split")
  vim.api.nvim_win_set_buf(0, buf)
end, { desc = "Show LSP clients' mise roots and runtime resolution" })
