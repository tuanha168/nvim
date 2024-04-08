return {
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
  -- on_new_config = function(new_config, new_root_dir)
  --   new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  -- end,
}
