local M = {}

M.setup = function()
  local saga = require "lspsaga"
  saga.init_lsp_saga {
    code_action_lightbulb = {
      enable = false,
    },
    code_action_keys = {
      quit = "q",
      exec = "<tab>",
    },
  }
end

return M
