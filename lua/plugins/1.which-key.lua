return {
  {
    "folke/which-key.nvim",
    priority = 10000,
    lazy = false,
    opts = {
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)
    end,
    keys = require "mappings",
  },
}
