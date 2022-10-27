local M = {}
local telescope = require "telescope"

M.setup = function()
  telescope.load_extension "project"
end

return M
