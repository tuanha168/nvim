---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  settings = {
    ["rust-analyzer"] = {
      lens = {
        enable = true,
      },
      checkOnSave = true,
    },
  },
}
