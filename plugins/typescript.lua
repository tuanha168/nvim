return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = require("astronvim.utils.lsp").on_attach,
      handlers = function()
        local user_opts = astronvim.user_opts

        user_opts("lsp.setup_handlers", {
          function(server, opts) require("lspconfig")[server].setup(opts) end,
        })
      end,
    },
  },
}
