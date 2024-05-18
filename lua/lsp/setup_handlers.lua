return {
  rust_analyzer = require "lsp.handlers.rust_analyzer",
  efm = require "lsp.handlers.efm",
  tsserver = require "lsp.handlers.tsserver",
  eslint = function(_, opts)
    require("lspconfig").eslint.setup(opts)
  end,
  -- volar = function() end,
}
