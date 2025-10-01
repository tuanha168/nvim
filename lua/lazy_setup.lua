require("lazy").setup {
  spec = {
    {
      "folke/which-key.nvim",
      priority = 10000,
      lazy = false,
      config = function(_, opts)
        local wk = require "which-key"
        wk.setup(opts)
      end,
      keys = require "mappings",
    },
    { import = "plugins" },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      config = true,
      opts = {
        library = {
          "~/.local/share/nvim/lazy/",
        },
      },
    },
    -- {
    --   "tuanha168/magenta-history.nvim",
    --   dev = true,
    --   dir = "~/.local/share/nvim/dev-plugins/magenta-history.nvim",
    --   dependencies = {
    --     "dlants/magenta.nvim",
    --     "folke/snacks.nvim",
    --   },
    --   opts = {},
    -- },
  },
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "Mofiqul/dracula.nvim" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
}
