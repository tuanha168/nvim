local M = {}

M.setup = function()
  require("leap").add_default_mappings()
  require("leap").opts.case_sensitive = false
end

return M
