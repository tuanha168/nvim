function Chiruno.get_text_selection()
  local selection = Chiruno.get_selection()
  if selection == nil then return end

  local selectedText = { selection.startText }
  if #selection.currentLine > 2 then
    vim.list_extend(selectedText, vim.list_slice(selection.currentLine, 2, #selection.currentLine - 1))
  end
  table.insert(selectedText, selection.endText)
  return { text = table.concat(selectedText, "\n"), selection = selection }
end

return Chiruno.get_text_selection
