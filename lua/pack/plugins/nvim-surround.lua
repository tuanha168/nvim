local lazy = require("pack.lazy-load")

lazy.on_event(
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
  "BufRead",
  function()
    require("nvim-surround").setup()
  end
)
