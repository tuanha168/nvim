local M = {}
local telescope = require "telescope"
local yanky, _ = pcall(require, "yanky")

M.setup = function()
  telescope.load_extension "project"
  if yanky then
    telescope.load_extension "yank_history"
  end
end

return M
