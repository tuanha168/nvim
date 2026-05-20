local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/hat0uma/csvview.nvim",
  "FileType",
  function()
    require("csvview").setup()
  end,
  { pattern = "csv" }
)
