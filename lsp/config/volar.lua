local home = require("os").getenv "HOME"
local util = require "lspconfig.util"

local function get_typescript_server_path(root_dir)
  local global_ts = home .. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then return path end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

return {
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  on_attach = function(client)
    if vim.fn.has "nvim-0.7" then
      -- nightly
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    else
      -- stable
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end,
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
}
