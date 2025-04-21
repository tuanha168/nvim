local util = require "lspconfig.util"

---@type lspconfig.options.tailwindcss
return {
  root_dir = util.root_pattern("tailwind.config.ts", "tailwind.config.js"),
  settings = {
    tailwindCSS = {
      -- classAttributes = {
      --   "class",
      --   "className",
      --   "ngClass",
      --   ".*[cC]lass.*",
      --   ".*[cC]lasses.*",
      -- },
      -- experimental = {
      --   classRegex = {
      --     "[a-zA-Z]*[cC]lass(es)?\\s*=\\s*'([^']*)'",
      --     '[a-zA-Z]*[cC]lass(es)?\\s*=\\s*"([^"]*)"',
      --     "[a-zA-Z]*[cC]lass(es)?\\s*=\\s*\\{(['`\"][^\\{\\}'`\"]*['`\"])*\\}",
      --   },
      -- },
      emmetCompletions = true,
    },
  },
}
