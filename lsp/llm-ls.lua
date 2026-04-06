---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  root_markers = { "tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json", ".git" },
  cmd = { "llm-ls" },
  settings = {
    model = "qwen2.5-coder:14b",
  },
}
