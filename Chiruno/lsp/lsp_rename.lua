function Chiruno.lsp.get_clients(opts)
  local ret = {} ---@type lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client lsp.Client
      ret = vim.tbl_filter(function(client) return client.supports_method(opts.method, { bufnr = opts.bufnr }) end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

function M.will_rename_files(files, options)
  options = options or {}
  local clients = Chiruno.lsp.get_clients()

  local edits = {}
  for _, client in ipairs(clients) do
    local filters = vim.tbl_get(client.server_capabilities, "workspace", "fileOperations", "willRename", "filters")
    local matching_files = get_matching_paths(client, filters, vim.tbl_keys(files))
    if matching_files then
      local params = {
        files = vim.tbl_map(
          function(src_file)
            return {
              oldUri = vim.uri_from_fname(src_file),
              newUri = vim.uri_from_fname(files[src_file]),
            }
          end,
          matching_files
        ),
      }
      local result, err =
        ---@diagnostic disable-next-line: invisible
        client.request_sync(ms.workspace_willRenameFiles, params, options.timeout_ms or 1000, 0)
      if result and result.result then
        if options.apply_edits ~= false then
          vim.lsp.util.apply_workspace_edit(result.result, client.offset_encoding)
        end
        table.insert(edits, { edit = result.result, offset_encoding = client.offset_encoding })
      else
        return nil, err or result and result.err
      end
    end
  end
  return edits
end

return Chiruno.lsp.on_rename
