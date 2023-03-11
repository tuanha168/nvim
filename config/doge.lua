local M = {}

M.setup = function()
  vim.api.nvim_exec(
    [[
      let g:doge_filetype_aliases = {
      \  'javascript': ['vue']
      \}
    ]],
    true
  )
end

return M
