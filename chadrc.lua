local M = {}

M.plugins = "custom.plugins"

M.ui = {
  transparency = true,
  theme = "onedark",
  hl_override = {
    CursorLine = {
      bg = "#282a2e",
    },
    Operator = {
      fg = "#efa0b7",
      sp = "none",
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
