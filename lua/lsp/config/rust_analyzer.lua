---@type lspconfig.options.rust_analyzer
return {
  settings = {
    ["rust-analyzer"] = {
      lens = {
        enable = "true",
      },
      checkOnSave = {
        command = "clippy",
        enable = "true",
      },
    },
  },
}
