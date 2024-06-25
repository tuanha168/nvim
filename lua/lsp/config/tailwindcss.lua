local util = require "lspconfig.util"

return {
  root_dir = util.root_pattern("tailwind.config.ts", "tailwind.config.js"),
}
