local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd "set laststatus&"
    vim.cmd "syntax sync fromstart"
  end,
})

autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd "checktime"
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.conf",
  callback = function()
    vim.cmd "setf dosini"
  end,
})

require "custom.config.colors"
require "custom.config.default"
