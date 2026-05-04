function Chiruno.func.format_lsp()
  local ignoreLsp = { "lua_ls", "vue_ls", "vtsls", "tsgo", "jsonls" }
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients { bufnr = bufnr }
  local has_formatter = false

  for _, client in ipairs(clients) do
    if client:supports_method("textDocument/formatting", bufnr) and not vim.tbl_contains(ignoreLsp, client.name) then
      has_formatter = true
      break
    end
  end

  if not has_formatter then return false end
  local formatOpts = require "lsp.format"
  formatOpts.filter = function(client) return not vim.tbl_contains(ignoreLsp, client.name) end

  vim.lsp.buf.format(formatOpts)

  return true
end

return Chiruno.func.format_lsp
