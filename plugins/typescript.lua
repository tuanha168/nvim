return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "json",
      "jsonc",
      "vue",
    },
    opts = {
      on_attach = require("astronvim.utils.lsp").on_attach,
      handlers = { function(server) require("astronvim.utils.lsp").setup(server) end },
    },
  },
}
