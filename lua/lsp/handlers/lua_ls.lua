return function(_, opts)
  opts.settings = opts.settings or {}
  opts.settings.hint = opts.settings.hint or {}

  opts.settings.hint.enable = true
  Print(vim.inspect(opts))

  local test = {
    1,
    2,
    3,
    4,
    5,
  }

  require("lspconfig").lua_ls.setup(opts)
end
