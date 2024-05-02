return {
  compilerOptions = {
    noErrorTruncate = true,
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
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = require("mason-registry").get_package("vue-language-server"):get_install_path()
            .. "/node_modules/@vue/language-server",
        languages = { "javascript", "typescript", "vue" },
      },
    },
    tsserver = {
      -- This overwrite the path from the local project, in case your project ts version is not compatible with the plugin
      path = require("mason-registry").get_package("typescript-language-server"):get_install_path()
          .. "/node_modules/typescript/lib",
    },
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      -- includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      -- includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
}
