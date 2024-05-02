local M = {}

M.setup = function()
  vim.api.nvim_exec(
    [[
      hi MatchWord ctermfg=red guibg=#26071d guifg=cyan cterm=underline gui=underline
      hi MatchParen ctermfg=red guibg=#26071d guifg=cyan cterm=underline gui=underline
    ]],
    false
  )
end

return M
