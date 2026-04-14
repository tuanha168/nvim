local lazy = require("pack.lazy-load")

lazy.on_command(
  "https://github.com/williamboman/mason.nvim",
  "Mason",
  function()
    require("mason").setup()
  end
)
