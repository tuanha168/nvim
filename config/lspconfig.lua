local lspconfig = require "lspconfig"

local servers = { "html", "eslint", "tsserver", "sumneko_lua", "intelephense", "vuels", "cssls" }
local handlers = require "custom.config.lsp.handlers"

for _, lsp in ipairs(servers) do
  local settings = {}
  if lsp == "sumneko_lua" then
    settings = require "custom.config.lsp.sumneko_lua"
  end
  lspconfig[lsp].setup {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    settings = settings,
  }
  handlers.setup()
end
