function Chiruno.motions.search(mode)
  local getSelection = Chiruno.get_text_selection(mode)
  if not getSelection then return end

  vim.api.nvim_win_set_cursor(0, { getSelection.selection.startRow, getSelection.selection.startCol })

  vim.fn.setreg("/", getSelection.escapedText)
  vim.opt.hlsearch = true
end
