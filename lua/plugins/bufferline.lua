return {
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = {
  --     tabline = {
  --       lualine_a = {
  --         {
  --           "buffers",
  --           separator = " c ",
  --         },
  --       },
  --       lualine_z = { "tabs" },
  --     },
  --   },
  -- },

  { "akinsho/bufferline.nvim", event = "VeryLazy", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },
}
