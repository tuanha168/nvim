local lspconfig = require "lspconfig"

local servers = {
  "angularls",
  -- "html",
  "volar",
  "tsserver",
  "eslint",
  "sumneko_lua",
  "intelephense",
  "cssls",
  "pylsp",
}
local home = require("os").getenv "HOME"
local util = require "lspconfig.util"
local function get_typescript_server_path(root_dir)
  local global_ts = home
    .. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserverlibrary.js"
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib", "tsserverlibrary.js")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

local handlers = require "custom.config.lsp.handlers"

for _, lsp in ipairs(servers) do
  local settings = {}
  if lsp == "volar" then
    lspconfig[lsp].setup {
      on_new_config = function(new_config, new_root_dir)
        new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
      end,
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
      -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    }
  else
    if lsp == "sumneko_lua" then
      settings = require "custom.config.lsp.sumneko_lua"
    end
    lspconfig[lsp].setup {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
      settings = settings,
    }
  end
  handlers.setup()
end
