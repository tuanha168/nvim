return function(_, opts)
  local registry = require "mason-registry"

  local vuePlugin = registry.get_package("vue-language-server"):get_install_path()
    .. "/node_modules/@vue/language-server"

  opts.init_options.plugins = {
    {
      name = "@vue/typescript-plugin",
      location = vuePlugin,
      languages = {
        "javascript",
        "javascript.jsx",
        "javascriptreact",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "vue",
      },
    },
  }
  require("lspconfig").ts_ls.setup(opts)
end
