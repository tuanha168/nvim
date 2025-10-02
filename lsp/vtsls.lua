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
