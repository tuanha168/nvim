local M = {}

M.setup = function()
  require("leap").setup {
    case_sensitive = true,
  }
end

return M
