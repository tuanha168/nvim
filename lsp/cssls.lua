---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
---@type lspconfig.options.cssls
return {
  filetypes = {
    "html",
    "scss",
    "css",
  },
  settings = {
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
}
