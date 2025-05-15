---@type LazySpec
return {
  {
    "rest-nvim/rest.nvim",
    enabled = false,
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
            },
          },
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "rest_nvim_result" },
        callback = function(e)
          vim.api.nvim_buf_set_keymap(
            e.buf,
            "n",
            "q",
            "<cmd>close<CR>",
            { noremap = true, silent = true, desc = "Close" }
          )
        end,
      })
    end,
  },
}
