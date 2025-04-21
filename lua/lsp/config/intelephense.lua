local util = require "lspconfig.util"

---@type lspconfig.options.intelephense
return {
  root_dir = util.root_pattern("docker-compose.yml", "composer.json", ".git"),
  settings = {
    intelephense = {
      format = { braces = "k&r" },
      diagnostics = {
        undefinedFunctions = false,
        undefinedConstants = false,
        undefinedClassConstants = false,
        undefinedMethods = false,
        undefinedProperties = false,
        undefinedVariables = false,
        undefinedTypes = false,
      },
    },
  },
}
