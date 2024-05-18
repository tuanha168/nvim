return function(client, bufnr)
  if client.server_capabilities.workspace then
    client.server_capabilities.workspace.didChangeWatchedFiles = client.server_capabilities.workspace.didChangeWatchedFiles
      or {}
    client.server_capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }
  end
  -- if client.server_capabilities.inlayHintProvider then
  --   if vim.lsp.inlay_hint and not vim.lsp.inlay_hint.is_enabled(bufnr) then vim.lsp.inlay_hint.enable() end
  -- end
  if client.name == "eslint" then
    Print(client.name)
    client.resolved_capabilities = client.resolved_capabilities or {}
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true
    Print(client.resolved_capabilities)
    require("null-ls").disable { "prettierd" }
  end

  if client.name == "rust_analyzer" then
    local rt = require "rust-tools"
    vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
  end
end
