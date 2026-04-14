vim.pack.add {
  {
    src = "https://github.com/max397574/better-escape.nvim",
    version = "7e86edafb8c7e73699e0320f225464a298b96d12"
  }
}

require("better_escape").setup {
  mapping = { "jk", "jj", "kk" },
  clear_empty_lines = true,
}
