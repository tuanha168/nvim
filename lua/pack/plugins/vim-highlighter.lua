local lazy = require "pack.lazy-load"

-- select N then press the key to pick a color, e.g. visual-select then "3<leader>h"
vim.g.HiSetSL = "<leader>h"
vim.g.HiErase = "<leader>hc"
vim.g.HiClear = "<leader>hc"

lazy.on_event(
  "https://github.com/azabiong/vim-highlighter",
  "BufRead",
  function() end
)
