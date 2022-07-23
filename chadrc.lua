local userPlugins = require "custom.plugins"

local M = {}

M.options = {
  user = function()
    require "custom.config.default"
  end,
}

M.plugins = {
  override = {
    ["NvChad/ui"] = {
      tabufline = {
        lazyload = false,
      },
    },
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.config.lspconfig",
    },
    cmp = {
      lazy_load = false,
    },
  },
  user = userPlugins,
  remove = {},
}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  transparents = true,
  -- theme = "gruvchad",
}

return M
