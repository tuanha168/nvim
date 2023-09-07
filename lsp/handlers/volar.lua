return function(_, opts)
  Chiruno.print(opts.document_config.default_config.cmd)
  opts.document_config.default_config.cmd = {
    "vue-language-server",
    "--stdio",
  }
  return opts
end
