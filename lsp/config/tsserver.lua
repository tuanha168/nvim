local function get_typescript_server_path()
  local global_ts = os.getenv "HOME"
    .. "/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin"
  return global_ts
end

return {
  init_options = {
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
  --     plugins = {
  --       name = "@vue/typescript-plugin",
  --       location = get_typescript_server_path(new_root_dir),
  --       languages = { "javascript", "typescript", "vue" },
  --     },
  --   }
  -- end,
}
