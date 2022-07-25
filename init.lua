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
    autocmd FileType php setlocal commentstring=\/\/\ \ %s
    let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
  ]],
  false
)

require "custom.config.colors"
require "custom.config.default"
