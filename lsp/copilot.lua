---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  root_markers = { "tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json", ".git" },
  cmd = { "mise", "exec", "node@22", "--", "copilot-language-server", "--stdio" },
  settings = {
    github = {
      copilot = {
        selectedCompletionModel = "gpt-5",
      },
    },
  },
}
