local M = {}

function M.hover()
  vim.lsp.buf.hover({ max_width = 120 })
end

return M
