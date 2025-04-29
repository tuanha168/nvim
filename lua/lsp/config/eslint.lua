local util = require "lspconfig.util"

---@type lspconfig.options.eslint
return {
  -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json", "svg" },
  root_dir = util.root_pattern(
    ".git"
    -- ".eslintrc",
    -- ".eslintrc.cjs",
    -- ".eslintrc.js",
    -- ".eslintrc.ts",
    -- ".eslintrc.json",
    -- ".eslintrc.yml",
    -- "eslint.config.js",
    -- "eslint.config.mjs",
    -- "eslint.config.ts"
  ),
  settings = {
    eslint = {
      experimental = {
        -- allows to use flat config format
        useFlatConfig = true,
      },
    },
  },
}
