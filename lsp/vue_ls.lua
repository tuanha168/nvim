local home = os.getenv "HOME"

return {
  root_markers = { ".git", "tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json" },
  settings = {
    vue = {
      inlayHints = {
        destructuredProps = {
          enabled = true,
        },
        inlineHandlerLoading = {
          enabled = true,
        },
        missingProps = {
          enabled = true,
        },
        optionsWrapper = {
          enabled = true,
        },
        vBindShorthand = {
          enabled = true,
        },
      },
    },
  },
}
