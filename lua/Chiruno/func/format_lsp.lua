function Chiruno.func.format_lsp()
  local ignoreLsp = { "vue_ls", "vtsls", "tsgo", "jsonls" }
  local bufnr = vim.api.nvim_get_current_buf()

  -- Tìm client có capability formatting
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local has_formatter = false

  for _, client in ipairs(clients) do
    if client:supports_method('textDocument/formatting', bufnr)
       and not vim.tbl_contains(ignoreLsp, client.name) then
      has_formatter = true
      break
    end
  end

  if not has_formatter then
    return false  -- Không có formatter khả dụng
  end

  -- Thực hiện format
  vim.lsp.buf.format {
    filter = function(client)
      return not vim.tbl_contains(ignoreLsp, client.name)
    end,
    async = false,
  }

  return true
end

return Chiruno.func.format_lsp
