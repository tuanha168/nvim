---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  cmd = { "mise", "exec", "node@22", "--", "copilot-language-server", "--stdio" },
}
