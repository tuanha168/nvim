return function(_, opts)
  opts.document_config.default_config.cmd = {
    "vue-language-server",
    "--stdio",
  }
  return opts
end
