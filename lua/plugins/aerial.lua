---@type LazySpec
return {
  {
    "stevearc/aerial.nvim",
    opts = {},
    key = {
      { "<Leader>o", function() require("aerial").snacks_picker() end, desc = "Symbols outline" },
      { "<Leader>O", function() require("aerial").toggle() end,        desc = "Symbols outline" },
    }
  },
}
