vim.g.VM_default_mappings = 0
vim.g.VM_maps = {
  ["Find Under"] = "<C-e>",
  ["Find Subword Under"] = "<C-e>",
  ["Switch Mode"] = "v",
}

local lazy = require("pack.lazy-load")

lazy.on_event("https://github.com/mg979/vim-visual-multi", "BufRead", function() end)
