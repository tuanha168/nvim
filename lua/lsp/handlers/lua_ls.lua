return function(_, opts)
  opts.settings = opts.settings or {}
  opts.settings.hint = opts.settings.hint or {}

  opts.settings.hint.enable = true

  require("lspconfig").lua_ls.setup(opts)
end
