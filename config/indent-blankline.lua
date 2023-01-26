local M = {}

M.setup = function()
  vim.opt.list = true
  require("indent_blankline").setup {
    char = "",
    space_char_blankline = " ",
    show_current_context = true,
  }
end

return M
