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
    experimental = {
      -- allows to use flat config format
      useFlatConfig = false,
    },
  },
  -- on_init = function(client)
  --   client.on_attach = function(_, buf) vim.b[buf].formatByLsp = true end
  -- end,
}
