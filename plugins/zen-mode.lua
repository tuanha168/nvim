return {
  {
    "folke/zen-mode.nvim",
    event = "BufEnter",
    opts = {
      window = {
        width = 0.60,
      },
    },
    keys = {
      { "<leader>z", function() require("zen-mode").toggle() end, desc = "Zen Mode" },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "try_statement",
      },
    },
  },
}
