---@type LazySpec
return {
  {
    "stevearc/aerial.nvim",
    opts = {},
    keys = {
      { "<leader>o", function() require("aerial").snacks_picker() end, desc = "Symbols outline" },
      { "<leader>O", function() require("aerial").toggle() end,        desc = "Symbols outline" },
    }
  },
}
