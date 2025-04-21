---@type LazySpec
return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    ft = { "http" },
    keys = {
      { "<leader>er", "<Plug>RestNvim", desc = "Run" },
    },
    config = function()
      ---@type rest.Opts
      -- vim.g.rest_nvim = {
      -- }
    end,
  },
}
