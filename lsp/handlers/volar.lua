return function(_, opts)
  opts.document_config.default_config.cmd = {
    "vue-language-server",
    "--stdio",
  }
  require("lspconfig").volar.setup(opts)
end
