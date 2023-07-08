return {
  {
    "echasnovski/mini.ai",
    config = function() require("mini.ai").setup() end,
    event = "BufRead",
  },
  {
    "echasnovski/mini.bufremove",
    event = "BufRead",
    opts = {
      silent = true,
    },
  },
}
