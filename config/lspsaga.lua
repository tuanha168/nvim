local M = {}

M.setup = function()
  local saga = require "lspsaga"
  saga.setup({})
  -- saga.init_lsp_saga {
  --   code_action_lightbulb = {
  --     enable = false,
  --   },
  --   code_action_keys = {
  --     quit = "q",
  --     exec = "<tab>",
  --   },
  --   finder_action_keys = {
  --     open = "<CR>",
  --   },
  -- }
end

return M
