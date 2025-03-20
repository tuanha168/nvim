function Chiruno.lsp.get_clients()
  local ret = {}
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients()
  end
  return ret
end

function Chiruno.lsp.on_rename(from, to)
  local clients = Chiruno.lsp.get_clients()

  for _, client in ipairs(clients) do
    if client.supports_method "workspace/willRenameFiles" then
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)

        client.notify("workspace/didRenameFiles", {
          files = {
            {
              oldUri = vim.uri_from_fname(from),
              newUri = vim.uri_from_fname(to),
            },
          },
        })
      end
    end
  end
end

return Chiruno.lsp.on_rename
