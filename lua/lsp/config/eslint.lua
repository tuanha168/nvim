local util = require "lspconfig.util"

local masonBin = require("mason-registry").get_package("eslint"):get_install_path()
  .. "/node_modules/typescript/lib"

return {
  -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json" },
  cmd = { "eslint", "--stdio" },
  root_dir = util.root_pattern(
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.ts",
    ".eslintrc.json",
    ".eslintrc.yml",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.ts"
  ),
}
