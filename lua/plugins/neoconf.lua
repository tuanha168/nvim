---@type LazySpec
return {
  {
    "folke/neoconf.nvim",
    build = "luarocks install json.lua",
    opts = {
      lua_ls = {
        enabled = true,
      },
    },
  },
}
