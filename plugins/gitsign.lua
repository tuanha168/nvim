return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local conf = require "user.config.gitsign"
      for k, v in pairs(conf) do
        opts[k] = v
      end
    end,
  },
}
