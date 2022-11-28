local M = {}

M.setup = function()
  vim.api.nvim_set_keymap("i", "<C-CR>", "copilot#Accept('<CR>')", { noremap = true, silent = true, expr = true })
end

return M
