return {
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function() require("mini.ai").setup() end,
    event = "BufRead",
  },

  {
    "echasnovski/mini.bufremove",
    opts = {
      silent = true,
    },
  },
}
