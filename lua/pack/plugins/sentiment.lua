vim.g.loaded_matchparen = 1

local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/utilyre/sentiment.nvim",
  "VimEnter",
  function()
    vim.schedule(function()
      require("sentiment").setup()
    end)
  end
)
