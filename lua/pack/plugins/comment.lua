vim.pack.add {
  "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
  "https://github.com/numToStr/Comment.nvim"
}

vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    local ft = require "Comment.ft"
    ft.set("conf", "# %s")
    ft.set("dosini", "# %s")
    ft.set("hyprlang", "# %s")
    require("Comment").setup({
      ignore = "^$",
    })
  end,
  once = true
})
