function Chiruno.get_text_selection(motion_type)
  local selection = Chiruno.get_selection()
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
