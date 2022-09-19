local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter" }, {
  callback = function()
    vim.cmd "set laststatus&"
  end,
})

vim.api.nvim_exec(
  [[
    autocmd FocusGained,BufEnter * :checktime
    autocmd BufEnter * syntax sync fromstart
    autocmd BufRead,BufNewFile *.conf setf dosini
    autocmd FileType php setlocal commentstring=\/\/\ \ %s
  ]],
  false
)

require "custom.config.colors"
require "custom.config.default"
