return {
  {
    "chrisgrieser/nvim-spider",
    opts = {},
    keys = {
      -- Keymaps
      { "w", function() require("spider").motion "w" end, desc = "Spider-w", mode = { "n", "x", "o" } },
      { "e", function() require("spider").motion "e" end, desc = "Spider-e", mode = { "n", "x", "o" } },
      { "b", function() require("spider").motion "b" end, desc = "Spider-b", mode = { "n", "x", "o" } },
      { "ge", function() require("spider").motion "ge" end, desc = "Spider-ge", mode = { "n", "x", "o" } },
    },
  },
}
