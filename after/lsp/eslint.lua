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
  settings = {
    eslint = {
      experimental = {
        -- allows to use flat config format
        useFlatConfig = true,
      },
    },
  },
  on_init = function(client)
    local old_on_attach = client.on_attach
    client.on_attach = function(_, buf)
      old_on_attach(_, buf)
      vim.b[buf].formatByLsp = true
    end
  end,
}
