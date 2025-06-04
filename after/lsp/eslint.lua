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
  on_init = function(client, _, buf)
    Print(client, buf)
    if client.name == "eslint" or client.name == "eslintd" then vim.b[e.buf].haveEslint = true end
  end,
}
