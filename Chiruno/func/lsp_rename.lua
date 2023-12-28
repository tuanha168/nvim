function Chiruno.func.on_rename(from, to)
  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method "workspace/willRenameFiles" then
      ---@diagnostic disable-next-line: invisible
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding) end
    end
  end
end

return Chiruno.func.on_rename
