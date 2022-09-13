local M = {}
local m = require "markid"
M.setup = function()
  require("nvim-treesitter.configs").setup {
    markid = {
      enable = true,
      colors = m.colors.bright,
    },
  }
end

return M
