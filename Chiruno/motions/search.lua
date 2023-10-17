function Chiruno.search(mode)
  local selection = Chiruno.get_text_selection(mode)
  if not selection then return end

  vim.api.nvim_win_set_cursor(0, { selection.selection.startRow, selection.selection.startCol })

  vim.fn.setreg("/", selection.escapedText)
  vim.opt.hlsearch = true
end
