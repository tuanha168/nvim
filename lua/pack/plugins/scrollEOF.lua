local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/Aasim-A/scrollEOF.nvim",
  "BufRead",
  function()
    require("scrollEOF").setup()
  end
)
