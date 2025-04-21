local volarPath = require("mason-registry").get_package("vue-language-server"):get_install_path()
Print(volarPath)

return {
  -- enabled = false,
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  compilerOptions = {
    noErrorTruncate = true,
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = volarPath .. "/node_modules/@vue/typescript-plugin",
        languages = { "javascript", "typescript", "vue" },
      },
    },
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",

      includeInlayVariableTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
    },
  },
}
