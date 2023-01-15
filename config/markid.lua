local M = {}
M.setup = function()
  local m = require "markid"
  local configs = require "nvim-treesitter.configs"
  configs.setup {
    markid = {
      enable = true,
      colors = m.colors.medium,
    },
  }
end

return M
