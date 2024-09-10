---@type LazySpec
return {
  {
    "folke/neoconf.nvim",
    build = "luarocks install json.lua",
    opts = {
      plugin = {
        ---@type lspconfig.options
        lspconfig = {

        }
      },
      lua_ls = {
        enabled = true,
      },
    },
  },
}
