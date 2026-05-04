---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json", "svg" },
  root_markers = {
    ".eslintrc",
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.ts",
    ".eslintrc.json",
    ".eslintrc.yml",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.ts",
  }
}
