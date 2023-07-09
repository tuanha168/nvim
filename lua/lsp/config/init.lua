local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
M.capabilities.textDocument.completion.completionItem.resolveSupport =
  { properties = { "documentation", "detail", "additionalTextEdits" } }
M.capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

M.config = function(server_name)
  local server = require("lspconfig")[server_name]
  local lsp_opts = { capabilities = M.capabilities }
  if server_name == "jsonls" then -- by default add json schemas
    local schemastore_avail, schemastore = pcall(require, "schemastore")
    if schemastore_avail then
      lsp_opts.settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } }
    end
  end
  if server_name == "yamlls" then -- by default add yaml schemas
    local schemastore_avail, schemastore = pcall(require, "schemastore")
    if schemastore_avail then lsp_opts.settings = { yaml = { schemas = schemastore.yaml.schemas() } } end
  end
  if server_name == "lua_ls" then -- by default initialize neodev and disable third party checking
    pcall(require, "neodev")
    lsp_opts.settings = { Lua = { workspace = { checkThirdParty = false } } }
  end
  lsp_opts.on_attach = function(client, bufnr)
    Chiruno.set_mappings(require "lsp.mappings")
    server.on_attach(client, bufnr)
    require "lsp.on_attach"(client, bufnr)
  end

  return lsp_opts
end

return M
