return function(_, opts)
  -- local registry = require "mason-registry"

  -- local tsdk = registry.get_package("vue-language-server"):get_install_path() .. "/node_modules/typescript/lib"
  -- local vuePlugin = registry.get_package("vue-language-server"):get_install_path()
  --   .. "/node_modules/@vue/language-server"

  -- opts.init_options.plugins = {
  --   {
  --     name = "@vue/typescript-plugin",
  --     location = vuePlugin,
  --     languages = {
  --       "javascript",
  --       "javascript.jsx",
  --       "javascriptreact",
  --       "typescript",
  --       "typescript.tsx",
  --       "typescriptreact",
  --       "vue",
  --     },
  --   },
  -- }
  -- opts.init_options.ts_ls = {
  --   -- This overwrite the path from the local project, in case your project ts version is not compatible with the plugin
  --   path = tsdk,
  -- }
  -- require("lspconfig").ts_ls.setup(opts)
end
