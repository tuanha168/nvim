local util = require "lspconfig.util"
local function get_typescript_server_path(root_dir)
  local global_ts = os.getenv "HOME"
    .. "/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin"

  if not root_dir then return global_ts end

  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "@vue", "typescript-plugin")
    if util.path.exists(found_ts) then return path end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

return {
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = get_typescript_server_path(),
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },

  -- on_new_config = function(new_config, new_root_dir)
  --   new_config.init_options = {
  --     preferences = {
  --       includeInlayParameterNameHints = "all",
  --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --       includeInlayFunctionParameterTypeHints = true,
  --       includeInlayVariableTypeHints = true,
  --       includeInlayPropertyDeclarationTypeHints = true,
  --       includeInlayFunctionLikeReturnTypeHints = true,
  --       includeInlayEnumMemberValueHints = true,
  --       importModuleSpecifierPreference = "non-relative",
  --     },
  --     plugins = {
  --       {
  --         name = "@vue/typescript-plugin",
  --         location = get_typescript_server_path(new_root_dir),
  --         languages = { "javascript", "typescript", "vue" },
  --       },
  --     },
  --   }
  -- end,
}
