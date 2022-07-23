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
  },
  user = userPlugins,
  remove = {
    "folke/which-key.nvim",
  },
}

M.ui = {
  transparency = true,
  theme = "onedark",
}

M.mappings = require "custom.keymaps"

return M
