return {
  {
    "pocco81/true-zen.nvim",
    event = "BufEnter",
    keys = {
      { "<leader>z", "<cmd>TZAtaraxis<CR>", desc = "Zen Mode" },
    },
    opts = {
      modes = {
        ataraxis = {
          callbacks = {
            open_pre = function() require("lualine").hide() end,
            close_pre = function() require("lualine").hide { unhide = true } end,
          },
        },
      },
    },
  },
}
