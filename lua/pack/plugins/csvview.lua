local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/hat0uma/csvview.nvim",
  "FileType",
  function()
    require("csvview").setup({
      view = {
        display_mode = "highlight"
      }
    })
  end,
  { pattern = "csv" }
)
