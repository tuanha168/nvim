local inlayHints = {
  enumMemberValues = { enabled = "true" },
  propertyDeclarationTypes = { enabled = "true" },
  parameterNames = {
    enabled = "all",
    suppressWhenArgumentMatchesName = "true",
  },
  functionLikeReturnTypes = { enabled = "true" },
  -- variableTypes = {
  --   enabled = "true",
  --   suppressWhenTypeMatchesName = "true",
  -- },
  parameterTypes = { enabled = "true" },
}

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
  settings = {
    vtsls = {
      -- autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
      experimental = { maxInlayHintLength = 20 },
    },
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
