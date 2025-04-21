local volarPath = require("mason-registry").get_package("vue-language-server"):get_install_path()

---@type lspconfig.options.ts_ls
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
  compilerOptions = {
    noErrorTruncate = true,
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = volarPath .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
        languages = { "javascript", "typescript", "vue" },
      },
    },
    -- preferences = {
    --   includeInlayParameterNameHints = "all",
    --   includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --   includeInlayFunctionParameterTypeHints = true,
    --   includeInlayPropertyDeclarationTypeHints = true,
    --   includeInlayEnumMemberValueHints = true,
    --   importModuleSpecifierPreference = "non-relative",

    --   includeInlayVariableTypeHints = true,
    --   includeInlayFunctionLikeReturnTypeHints = true,
    -- },
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
      inlayHints = {
        enumMemberValues = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        parameterNames = {
          enabled = "all",
          suppressWhenArgumentMatchesName = true,
        },
        -- functionLikeReturnTypes = { enabled = "true" },
        -- variableTypes = {
        --   enabled = "true",
        --   suppressWhenTypeMatchesName = "true",
        -- },
        parameterTypes = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        parameterNames = {
          enabled = "all",
          suppressWhenArgumentMatchesName = true,
        },
        -- functionLikeReturnTypes = { enabled = "true" },
        -- variableTypes = {
        --   enabled = "true",
        --   suppressWhenTypeMatchesName = "true",
        -- },
        parameterTypes = { enabled = true },
      },
    },
  },
}
