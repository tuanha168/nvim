function Chiruno.search(mode)
  local temp = Chiruno.get_text_selection(mode)
  if not temp then return end

  local _, escapedText, selection = unpack(temp)

  vim.api.nvim_win_set_cursor(0, { selection.startRow, selection.startCol })

  vim.fn.setreg("/", escapedText)
  vim.opt.hlsearch = true
end
