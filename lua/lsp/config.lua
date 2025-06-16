vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  show_diagnostic_autocmds = { "InsertLeave", "TextChanged" },
}

-- vim.lsp.inlay_hint.enable(true)
