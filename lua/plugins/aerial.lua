return {
  {
    "stevearc/aerial.nvim",
    opts = {}
    keys = {
      { "<Leader>o", function() require("aerial").snacks_picker() end, desc = "Symbols outline" },
      { "<Leader>o", function() require("aerial").toggle() end,        desc = "Symbols outline" },
    }
  },
}
