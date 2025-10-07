---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  root_markers = { "tailwind.config.ts", "tailwind.config.js" },
  settings = {
    tailwindCSS = {
      classAttributes = {
        "class",
        "className",
        ".*[cC]lass.*",
        ".*[cC]lasses.*",
      },
      experimental = {
        classRegex = {
          "[a-zA-Z]*[cC]lass(es)?\\s*=\\s*'([^']*)'",
          '[a-zA-Z]*[cC]lass(es)?\\s*=\\s*"([^"]*)"',
          "[a-zA-Z]*[cC]lass(es)?\\s*=\\s*\\{(['`\"][^\\{\\}'`\"]*['`\"])*\\}",
        },
      },
      includeLanguages = {
        plaintext = "vue",
      },
      emmetCompletions = true,
    },
  },
}
