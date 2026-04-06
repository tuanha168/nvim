---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  root_markers = { "tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json", ".git" },
  cmd = { "llm-ls" },
  settings = {
    github = {
      copilot = {
        selectedCompletionModel = "gpt-41-copilot",
      },
    },
  },
}
