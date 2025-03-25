function Chiruno.func.get_selection()
  local startRow, startCol
  local finishRow, finishCol

  if vim.api.nvim_get_mode().mode == "n" then
    startRow, startCol = unpack(vim.api.nvim_win_get_cursor(0))
    finishRow, finishCol = startRow, startCol
  else
    local posv = vim.fn.getpos "v"
    local posdot = vim.fn.getpos "."
    if posdot[2] > posv[2] then
      startRow, startCol = posv[2], posv[3]
      finishRow, finishCol = posdot[2], posdot[3]
    else
      startRow, startCol = posdot[2], posdot[3]
      finishRow, finishCol = posv[2], posv[3]
    end
  end

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

return Chiruno.func.get_selection
