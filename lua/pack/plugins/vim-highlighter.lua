local lazy = require "pack.lazy-load"

-- Press <leader>hN to always use HiColorN in normal or visual mode.
vim.g.HiSetSL = "<leader>h"
vim.g.HiErase = "<leader>hc"
vim.g.HiClear = "<leader>hc"

lazy.on_event(
  "https://github.com/azabiong/vim-highlighter",
  "BufRead",
  function()
    for color = 1, 10 do
      local key = "<leader>" .. color
      vim.keymap.set("n", key, function()
        vim.fn["highlighter#Command"]("+%", color)
        vim.cmd.nohlsearch()
      end, { silent = true, desc = "Highlight with HiColor" .. color })
      vim.keymap.set("x", key, function()
        vim.fn["highlighter#Command"]("+x%", color)
        vim.cmd.nohlsearch()
      end, { silent = true, desc = "Highlight selection with HiColor" .. color })
    end
  end
)
