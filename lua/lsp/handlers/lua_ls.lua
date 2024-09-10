return function(_, opts)
  opts.settings.hint.enable = true

  require("lspconfig").lua_ls.setup(opts)
end
