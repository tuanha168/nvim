---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  root_markers = { "docker-compose.yml", "composer.json", ".git" },
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
