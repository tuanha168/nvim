local userPlugins = require "custom.plugins"

local M = {}

M.plugins = userPlugins

M.ui = {
  transparency = true,
  theme = "onedark",
  hl_override = {
    CursorLine = {
      bg = "one_bg",
    },
  },
  changed_themes = {
    onedark = {
      base_16 = {
        base08 = "#fc97b7",
      },
    },
  },
}

M.mappings = require "custom.keymaps"

return M
