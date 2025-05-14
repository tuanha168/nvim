local home = os.getenv "HOME"

return {
  cmd = { home .. "/typescript-go/built/local/tsgo", "--lsp", "-stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
