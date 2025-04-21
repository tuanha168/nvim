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
        response = {
          ---Default response hooks
          ---@class rest.Config.Response.Hooks
          hooks = {
            ---@type boolean Decode the request URL segments on response UI to improve readability
            decode_url = true,
            ---@type boolean Format the response body using `gq` command
            format = false,
          },
        },
      }
    end,
  },
}
