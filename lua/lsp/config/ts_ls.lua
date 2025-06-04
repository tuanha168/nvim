local volarPath = require("mason-registry").get_package("vue-language-server"):get_install_path()

local inlayHints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayEnumMemberValueHints = true,
  -- includeInlayVariableTypeHints = true,
  -- includeInlayFunctionLikeReturnTypeHints = true,

  importModuleSpecifierPreference = "non-relative",
}

return {
  enabled = vim.g.vue_hybrid,
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  compilerOptions = {
    noErrorTruncate = true,
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "$MASON/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
        languages = { "vue" },
      },
    },
  },
  settings = {
    typescript = {
      tsserver = {
        web = {
          projectWideIntellisense = {
            enabled = true,
          },
        },
      },
      inlayHints = inlayHints,
    },
    javascript = {
      inlayHints = inlayHints,
    },
  },
}
