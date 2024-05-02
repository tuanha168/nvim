function Chiruno.func.feedkeys(key, mode)
  if not mode then mode = "n" end

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, false)
end

return Chiruno.func.feedkeys
