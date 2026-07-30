local gh = function(x) return "https://github.com/" .. x end

-- Startup-critical: must be loaded before plugin files are sourced.
-- Order matters: colorscheme → snacks → which-key
vim.pack.add({
  gh "Mofiqul/dracula.nvim",
  gh "mrjones2014/smart-splits.nvim",
  gh "folke/snacks.nvim",
  gh "folke/which-key.nvim",
  gh "goolord/alpha-nvim",
  gh "echasnovski/mini.icons",
}, { load = true })

require "mappings"

require "pack.plugins"
