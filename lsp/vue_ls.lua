local home = os.getenv "HOME"

return {
  root_markers = { ".git", "tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json" },
  settings = {
    -- vue = {
    --   inlayHints = {
    --     missingProps = true,
    --     optionsWrapper = true,
    --     vBindShorthand = true,
    --     destructuredProps = true,
    --     inlineHandlerLeading = true,
    --   },
    -- },
    typescript = {
      tsserver = {
        web = {
          projectWideIntellisense = {
            enabled = "true",
          },
        },
      },
      inlayHints = {
        enumMemberValues = { enabled = "true" },
        propertyDeclarationTypes = { enabled = "true" },
        parameterNames = {
          enabled = "all",
          suppressWhenArgumentMatchesName = "true",
        },
        -- functionLikeReturnTypes = { enabled = "true" },
        -- variableTypes = {
        --   enabled = "true",
        --   suppressWhenTypeMatchesName = "true",
        -- },
        parameterTypes = { enabled = "true" },
      },
    },
    javascript = {
      inlayHints = {
        enumMemberValues = { enabled = "true" },
        propertyDeclarationTypes = { enabled = "true" },
        parameterNames = {
          enabled = "all",
          suppressWhenArgumentMatchesName = "true",
        },
        -- functionLikeReturnTypes = { enabled = "true" },
        -- variableTypes = {
        --   enabled = "true",
        --   suppressWhenTypeMatchesName = "true",
        -- },
        parameterTypes = { enabled = "true" },
      },
    },
  },
}
