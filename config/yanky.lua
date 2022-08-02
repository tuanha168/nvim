local M = {}
local ok, telescope = pcall(require, "telescope")

M.setup = function()
  require("yanky").setup {}
  vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
end

return M
