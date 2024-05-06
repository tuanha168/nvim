return function(_, opts)
  local registry = require "mason-registry"

  local tsdk = registry.get_package("typescript-language-server"):get_install_path() .. "/node_modules/typescript/lib"
  local vuePlugin = registry.get_package("vue-language-server"):get_install_path()
    .. "/node_modules/@vue/language-server"

  -- opts.init_options.plugins = {
  --   {
  --     name = "@vue/typescript-plugin",
  --     location = vuePlugin,
  --     languages = { "javascript", "typescript", "vue" },
  --   },
  -- }
  -- opts.init_options.tsserver = {
  --   -- This overwrite the path from the local project, in case your project ts version is not compatible with the plugin
  --   path = tsdk,
  -- }
  require("lspconfig").tsserver.setup(opts)
end
