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

-- Track the mise root each LSP client was spawned under, for :MiseLspStatus
-- and :MiseLspRestart. lspconfig already spawns a new client per root_dir,
-- so auto-bouncing on project switch is unnecessary and causes flapping
-- (nested .tool-versions, subproject buffers, etc.).
local mise_markers = { "mise.toml", ".mise.toml", ".mise/config.toml", ".tool-versions" }
local spawn_root = {} -- client_id -> mise root at spawn time

local function mise_root(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == "" then return nil end
  local hit = vim.fs.find(mise_markers, { upward = true, path = path, type = "file" })[1]
  return hit and vim.fs.dirname(hit) or nil
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("MiseLspTrack", { clear = true }),
  callback = function(ev) spawn_root[ev.data.client_id] = mise_root(ev.buf) end,
})

vim.api.nvim_create_user_command("MiseLspRestart", function()
  for _, c in ipairs(vim.lsp.get_clients()) do
    spawn_root[c.id] = nil
    c:stop()
  end
  vim.notify("[mise] all LSP clients stopped; reopen buffers to respawn")
end, { desc = "Stop all LSP clients so they respawn under current PATH/cwd" })

vim.api.nvim_create_user_command("MiseLspStatus", function()
  local cur = vim.api.nvim_get_current_buf()
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  local lines = {}
  local function or_else(s, d) return s ~= "" and s or d end
  local function section(title, items)
    if #lines > 0 then lines[#lines + 1] = "" end
    lines[#lines + 1] = "── " .. title .. " ──"
    if #items == 0 then items = { "(none)" } end
    for _, s in ipairs(items) do lines[#lines + 1] = "  " .. s end
  end

  section("Current buffer", {
    "name     " .. or_else(vim.api.nvim_buf_get_name(cur), "(unnamed)"),
    "filetype " .. or_else(vim.bo[cur].filetype, "(none)"),
    "cwd      " .. vim.fn.getcwd(),
  })

  local global = vim.tbl_map(function(c)
    return ("%s  mise_root=%s  root_dir=%s"):format(c.name, spawn_root[c.id] or "-", c.config.root_dir or "-")
  end, vim.lsp.get_clients())
  section("Attached LSP clients (global)", global)

  local here = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = cur }))
  section("Attached to current buffer", here)

  local bins = vim.tbl_map(function(b)
    local p, mason = vim.fn.exepath(b), vim.fn.filereadable(mason_bin .. "/" .. b) == 1
    return ("%-28s %s%s"):format(b, or_else(p, "(not on PATH)"), mason and " [mason]" or "")
  end, { "vtsls", "typescript-language-server", "lua-language-server", "gopls", "rust-analyzer" })
  local els = vim.fn.expand("~/.local/share/elixir-ls/language_server.sh")
  bins[#bins + 1] = ("%-28s %s"):format("elixir-ls (launcher)",
    vim.fn.filereadable(els) == 1 and els or "(missing — run scripts/install-elixir-ls.sh)")
  section("LSP binary resolution", bins)

  local watched = { "lua_ls", "vtsls", "rust_analyzer", "elixirls", "erlangls", "gopls", "pyright", "jsonls", "yamlls", "bashls" }
  local reg = vim.tbl_map(function(name)
    local cfg = vim.lsp.config[name]
    local has_cfg = cfg ~= nil
    local enabled = pcall(vim.lsp.is_enabled, name) and vim.lsp.is_enabled(name) or false
    local cmd_ok = false
    if has_cfg and cfg.cmd then
      local c = type(cfg.cmd) == "table" and cfg.cmd[1] or nil
      cmd_ok = c and vim.fn.executable(c) == 1 or false
    end
    return ("%-14s config=%s  enabled=%s  cmd_ok=%s"):format(
      name, has_cfg and "yes" or "no", enabled and "yes" or "no", cmd_ok and "yes" or "n/a")
  end, watched)
  section("LSP registry state", reg)

  local tools = vim.tbl_map(function(t)
    return ("%-8s %s"):format(t, or_else(vim.fn.exepath(t), "(not found)"))
  end, { "node", "npm", "elixir", "mix", "erl", "go", "python3" })
  section("exepath from Neovim PATH", tools)

  local path = vim.split(vim.env.PATH or "", ":", { plain = true })
  section("PATH head", { unpack(path, 1, math.min(8, #path)) })

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "miselspstatus"
  vim.api.nvim_buf_set_name(buf, "MiseLspStatus")
  vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
  vim.cmd("botright " .. math.min(#lines + 2, 25) .. "split")
  vim.api.nvim_win_set_buf(0, buf)
end, { desc = "Show LSP clients' mise roots and runtime resolution" })
