return {
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.renameProvider = false
  end,
}
