function Chiruno.func.format_lsp()
  local ignoreLsp = { "ts_ls", "vue_ls", "vtsls" }

  vim.lsp.buf.format {
    filter = function(client) return not vim.tbl_contains(ignoreLsp, client.name) end,
    async = true,
  }
end

return Chiruno.func.format_lsp
