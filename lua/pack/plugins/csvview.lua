local lazy = require("pack.lazy-load")

vim.pack.add { "hat0uma/csvview.nvim" }

lazy.on_event(
  "https://github.com/toppair/peek.nvim",
  "FileType",
  function()
    require("peek").setup()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
  { pattern = "markdown" }
)
