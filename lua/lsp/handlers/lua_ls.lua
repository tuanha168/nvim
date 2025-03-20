return function(_, opts)
  opts.settings = opts.settings or {}
  opts.settings.Lua = opts.settings.Lua or {}
  opts.settings.Lua.hint = opts.settings.Lua.hint or {}

  opts.settings.Lua.hint.enable = true

  require("lspconfig").lua_ls.setup(opts)
end
