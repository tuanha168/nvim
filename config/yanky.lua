local M = {}
local ok, telescope = pcall(require, "telescope")

M.setup = function()
  require("yanky").setup {}
  if ok then
    telescope.load_extension "yank_history"
  end
  vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
end

return M
