return {
  -- {
  --   "mrjones2014/legendary.nvim",
  --   priority = 10000,
  --   lazy = false,
  --   opts = {
  --     extensions = {
  --       lazy_nvim = true,
  --       smart_splits = {
  --         directions = { "h", "j", "k", "l" },
  --         mods = {
  --           move = "<C>",
  --           resize = false,
  --           swap = false,
  --         },
  --       },
  --     },
  --     keymaps = require "mappings",
  --     autocmds = require "autocmds",
  --     commands = require "commands",
  --   },
  --   -- sqlite is only needed if you want to use frecency sorting
  --   -- dependencies = { 'kkharji/sqlite.lua' }
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)

      wk.add(require "mappings")
    end,
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
