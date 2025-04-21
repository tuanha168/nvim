local util = require "lspconfig.util"

return {
  root_dir = util.root_pattern("tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json"),
  filetypes = {
    "vue",
  },
  -- init_options = { vue = { hybridMode = false } },
}
