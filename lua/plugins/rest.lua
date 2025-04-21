---@type LazySpec
return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    ft = { "http" },
    keys = {
      { "<leader>er", "<cmd>Rest run<CR>", desc = "Run" },
    },
    config = function()
      ---@type rest.Opts
      vim.g.rest_nvim = {
        clients = {
          curl = {
            opts = {
              set_compressed = true,
            }
          }
        }
      }
    end,
  },
}
