---@type LazySpec
return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>er", function() require("kulala").run() end, desc = "Send request" },
      -- { "<leader>Ra", desc = "Send all requests" },
      -- { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      -- your configuration comes here
      global_keymaps = false,
    },
  },
}
