local eslint = require 'efmls-configs.linters.eslint'
local prettierd = require 'efmls-configs.formatters.prettier_d'
local stylua = require 'efmls-configs.formatters.stylua'
return{
  filetypes = {
    "lua"
  },
  init_options = {
      documentFormatting = true,
        hover= true,
        documentSymbol= true,
        codeAction= true,
        completion= true
    },
    settings = {
      rootMarkers = {".git/"},
        languages = {
            lua = {
        formatter = stylua,
            },javascript = {
    linter = eslint,
    formatter = prettierd,
  }
        }
    }}
