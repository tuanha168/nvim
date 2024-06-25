local util = require "lspconfig.util"

return {
  root_dir = util.root_pattern(
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.ts",
    ".eslintrc.json",
    ".eslintrc.yml"
  ),
}
