vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  show_diagnostic_autocmds = { "InsertLeave", "TextChanged" },
}

vim.lsp.inlay_hint.enable()

vim.lsp.inline_completion.enable()

vim.lsp.linked_editing_range.enable()

vim.lsp.document_color.enable(true, 0, {
  style = "virtual",
})


vim.lsp.config "vtsls"
