function Chiruno.get_selection()
  local startRow, startCol = unpack(vim.api.nvim_buf_get_mark(0, "["))
  local finishRow, finishCol = unpack(vim.api.nvim_buf_get_mark(0, "]"))
  local currentLine = vim.api.nvim_buf_get_lines(0, startRow - 1, finishRow, false)
  if #currentLine == 0 then return end
  local startText, endText
  if #currentLine == 1 then
    startText = string.sub(currentLine[1], startCol + 1, finishCol + 1)
  else
    startText = string.sub(currentLine[1], startCol + 1)
    endText = string.sub(currentLine[#currentLine], 1, finishCol + 1)
  end

  return {
    currentLine = currentLine,
    startRow = startRow,
    startCol = startCol,
    finishRow = finishRow,
    finishCol = finishCol,
    startText = startText,
    endText = endText,
  }
end

return Chiruno.get_selection
