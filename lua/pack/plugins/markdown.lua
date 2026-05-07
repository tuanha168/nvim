local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/OXY2DEV/markview.nvim",
  "FileType",
  function()
    require("markview").setup()
  end,
  { pattern = "markdown" }
)

require("which-key").add({
  { "<leader>mp", "<cmd>Markview splitToggle<cr>", desc = "Markdown Split Preview" },
})
