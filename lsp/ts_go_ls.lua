local home = os.getenv "HOME"

vim.lsp.config("ts_go_ls", {
  cmd = { home .. "/typescript-go/built/local/tsgo", "--lsp", "--stdio" },
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
  settings = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
        languages = { "vue" },
      },
    },
  },
})
