function Chiruno.func.format_lsp()
  local ignoreLsp = { "tsserver", "volar" }

  vim.lsp.buf.format {
    filter = function(client) return not vim.tbl_contains(ignoreLsp, client.name) end,
    async = true,
    timeout_ms = 500,
  }
end

return Chiruno.func.format_lsp
