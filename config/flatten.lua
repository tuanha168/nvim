require("flatten").setup {
  -- callbacks = {
  --   pre_open = function()
  --     vim.cmd "Lspsaga term_toggle"
  --   end,
  --   post_open = function(bufnr)
  --     vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  --       buffer = bufnr,
  --       once = true,
  --       callback = function()
  --         vim.defer_fn(function()
  --           vim.cmd "echo 'haha'"
  --           vim.cmd "tabclose"
  --         end, 50)
  --       end,
  --     })
  --   end,
  -- },
}
