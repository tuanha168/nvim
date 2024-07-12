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
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      -- includeInlayFunctionParameterTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      -- includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = "non-relative",

      -- includeInlayVariableTypeHints = true,
      -- includeInlayFunctionLikeReturnTypeHints = true,
    },
  },
}
