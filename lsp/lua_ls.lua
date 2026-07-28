---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      hint = {
        enable = true,
      },
      diagnostics = {
        disable = { "missing-fields" },
        globals = { "hl" },
      },
      workspace = {
        library = {
          "/usr/share/hypr/stubs",
        },
      },
    },
  },
}
