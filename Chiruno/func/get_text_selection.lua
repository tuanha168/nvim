function Chiruno.get_text_selection(motion_type)
  local selection = Chiruno.get_selection()
  if not selection then return end

  if motion_type == "line" then
    return vim.api.nvim_buf_get_lines(0, selection.startRow - 1, end_line, true)
  elseif motion_type == "char" then
    return vim.api.nvim_buf_get_text(0, start_line - 1, start_column, end_line - 1, end_column + 1, {})
  elseif motion_type == "block" then
    local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
    for i, line in ipairs(selected_lines) do
      selected_lines[i] = line:sub(start_column + 1, end_column + 1)
    end
    return selected_lines
  end
  if selection == nil then return end

  local special_symbols = "^$\\"
  if vim.api.nvim_get_option "magic" then special_symbols = "*^$.~[]\\" end

  local selectedText = { selection.startText }
  local escapedText = {}

  -- Escape all special_symbols
  for index, line in ipairs(selectedText) do
    escapedText[index] = vim.fn.escape(line, special_symbols)
  end

  return {
    text = table.concat(selectedText, "\\n"),
    escapedText = table.concat(escapedText, "\\n"),
    selection = selection,
  }
end

return Chiruno.get_text_selection
