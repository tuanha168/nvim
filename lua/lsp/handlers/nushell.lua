return function(client, bufnr)
  Print(client.name)
  require("lspconfig").nushell.setup {}
end
