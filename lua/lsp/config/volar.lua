local util = require "lspconfig.util"

return {
  root_dir = util.root_pattern("tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json"),
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  init_options = { vue = { hybridMode = false } },
}
