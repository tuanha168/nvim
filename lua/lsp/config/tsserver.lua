local registry = require "mason-registry"

local vuePlugin = registry.get_package("vue-language-server"):get_install_path() .. "/node_modules/@vue/language-server"

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
        location = vuePlugin,
        languages = { "javascript", "typescript", "vue" },
      },
    },
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",

      -- includeInlayVariableTypeHints = true,
      -- includeInlayFunctionLikeReturnTypeHints = true,
    },
  },
}
