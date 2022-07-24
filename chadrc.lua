local userPlugins = require "custom.plugins"

local M = {}

M.plugins = {
  user = userPlugins,
  override = {
    ["NvChad/ui"] = {
      tabufline = {
        lazyload = false,
      },
    },
  },
  remove = {
    "folke/which-key.nvim",
  },
}

M.ui = {
  transparency = true,
  theme = "tokyonight",
}

M.mappings = require "custom.keymaps"

return M
