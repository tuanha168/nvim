---@type LazySpec
return {
  {
    "folke/neoconf.nvim",
    build = "luarocks install json.lua",
    -- opts = {
    --   local_settings = 'neoconf.lua',
    -- }
  }
}
