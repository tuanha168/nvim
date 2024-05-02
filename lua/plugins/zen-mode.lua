---@type LazySpec
return {
  -- {
  --   "folke/zen-mode.nvim",
  --   event = "BufEnter",
  --   opts = {
  --     window = {
  --       width = 0.60,
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>z",
  --       function()
  --         -- close NeoTree
  --         local ok, neo = pcall(require, "neo-tree.command")
  --         if ok then neo.execute { action = "close" } end
  --
  --         require("zen-mode").toggle()
  --       end,
  --       desc = "Zen Mode",
  --     },
  --   },
  -- },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {
      context = 20,
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function_declaration",
        "if_statement",
        "try_statement",
        "arrow_function",
        "lexical_declaration",
      },
    },
  },
}
