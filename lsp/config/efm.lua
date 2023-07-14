local efmls = require 'efmls-configs'

local eslint = require 'efmls-configs.linters.eslint'
local prettierd = require 'efmls-configs.formatters.prettier_d'
local stylua = require 'efmls-configs.formatters.stylua'

efmls.init(
{
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
        lua = {}
      }
    }}
)

efmls.setup({
            lua = {
        formatter = stylua,
            },javascript = {
    linter = eslint,
    formatter = prettierd,
  }
        })

return {
  filetypes = {
    "lua"
  },

}
