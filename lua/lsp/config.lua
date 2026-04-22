vim.lsp.enable {
  "lua_ls",
  "vue_ls",
  "eslint",
  "tailwindcss",
  "jsonls",
  "yamlls",
  -- 'tsgo',
  "vtsls",
  "pyright",
  "qmlls",
  "copilot",
  "csharp-ls",
}

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

vim.lsp.document_color.enable(true, nil, {
  style = "virtual",
})
