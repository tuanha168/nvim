return {
  {
    "folke/zen-mode.nvim",
    event = "BufEnter",
    opts = {
      window = {
        width = 0.60,
      },
      on_close = function(a) Chiruno.print(a) end,
    },
    keys = {
      {
        "<leader>z",
        function()
          -- close NeoTree
          local ok, neo = pcall(require, "neo-tree.command")
          if ok then neo.execute { action = "close" } end

          require("zen-mode").toggle()
        end,
        desc = "Zen Mode",
      },
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
