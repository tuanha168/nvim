local lspconfig = require "lspconfig"

local servers = { "eslint", "tsserver", "sumneko_lua", "intelephense", "volar" }

for _, lsp in ipairs(servers) do
  local settings = {}
  if lsp == "sumneko_lua" then
    settings = require "custom.config.lsp.sumneko_lua"
  end
  lspconfig[lsp].setup {
    on_attach = require("custom.config.lsp.handlers").on_attach,
    capabilities = require("custom.config.lsp.handlers").capabilities,
    settings = settings,
  }
end
