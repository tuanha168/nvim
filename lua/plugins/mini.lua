return {
  {
    "echasnovski/mini.ai",
    config = function() require("mini.ai").setup() end,
    event = "BufRead",
  },

  {
    "echasnovski/mini.bufremove",
    opts = {
      silent = true,
    },
  },

  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
