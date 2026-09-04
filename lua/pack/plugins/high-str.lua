local lazy = require "pack.lazy-load"
local plugin = "https://github.com/pocco81/high-str.nvim"

lazy.on_key(plugin, {
  { "<leader>1", ":<c-u>HSHighlight 1<CR>", mode = "v", silent = true, desc = "Highlight group 1 (high-str)" },
  { "<leader>2", ":<c-u>HSHighlight 2<CR>", mode = "v", silent = true, desc = "Highlight group 2 (high-str)" },
  { "<leader>3", ":<c-u>HSHighlight 3<CR>", mode = "v", silent = true, desc = "Highlight group 3 (high-str)" },
  { "<leader>4", ":<c-u>HSHighlight 4<CR>", mode = "v", silent = true, desc = "Highlight group 4 (high-str)" },
  { "<leader>5", ":<c-u>HSHighlight 5<CR>", mode = "v", silent = true, desc = "Highlight group 5 (high-str)" },
  { "<leader>6", ":<c-u>HSHighlight 6<CR>", mode = "v", silent = true, desc = "Highlight group 6 (high-str)" },
  { "<leader>7", ":<c-u>HSHighlight 7<CR>", mode = "v", silent = true, desc = "Highlight group 7 (high-str)" },
  { "<leader>8", ":<c-u>HSHighlight 8<CR>", mode = "v", silent = true, desc = "Highlight group 8 (high-str)" },
  { "<leader>9", ":<c-u>HSHighlight 9<CR>", mode = "v", silent = true, desc = "Highlight group 9 (high-str)" },
  { "<leader>hc", ":<c-u>HSRmHighlight rm_all<CR>", mode = "n", silent = true, desc = "Remove all highlights (high-str)" },
  { "<leader>hc", ":<c-u>HSRmHighlight<CR>", mode = "v", silent = true, desc = "Remove highlight (high-str)" },
}, function()
  require("high-str").setup()
end)
