---@type lspconfig.options
return {
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = { enabled = "true" },
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
  },
}
