local M = {}

M.setup = function()
  vim.api.nvim_set_keymap("i", "<M-f>", "copilot#Accept('<CR>')", { noremap = true, silent = true, expr = true })
end

return M
