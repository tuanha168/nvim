return {
  -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json", "svg" },
  root_markers = {
    ".eslintrc",
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.ts",
    ".eslintrc.json",
    ".eslintrc.yml",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.ts",
  },
  on_init = function(_client)
    local old_on_attach = _client.on_attach
    _client.on_attach = function(client, buf)
      old_on_attach(client, buf)
      vim.b[buf].formatByLsp = true
    end
  end,
}
