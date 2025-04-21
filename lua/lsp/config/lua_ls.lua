---@type lspconfig.options.lua_ls
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      hint = {
        enable = true,
      },
      diagnostics = { disable = { "missing-fields" } },
    },
  },
}
