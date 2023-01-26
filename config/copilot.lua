local M = {}

M.setup = function()
  require("copilot").setup {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-f>",
        next = "<C-j>",
        prev = "<C-k>",
      },
    },
  }
end

return M
