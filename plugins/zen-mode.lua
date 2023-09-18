return {
  {
    "folke/zen-mode.nvim",
    event = "BufEnter",
    opts = {
      window = {
        width = 0.70,
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
    },
  },
  {
    "folke/twilight.nvim",
    event = "BufRead",
    opts = {
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
      },
    },
  },
}
