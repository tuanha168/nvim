function Chiruno.get_text_selection(motion_type)
  local selection = Chiruno.get_selection()
  if selection == nil then return end

  local selectedText = { selection.startText }
  if #selection.currentLine > 2 then
    vim.list_extend(selectedText, vim.list_slice(selection.currentLine, 2, #selection.currentLine - 1))
  end
  table.insert(selectedText, selection.endText)

  local pattern_to_search = table.concat(selectedText, "\\n")
  if motion_type == "line" then
    pattern_to_search = "^" .. selectedText .. "\\n"
  elseif motion_type == "block" then
    pattern_to_search = ".*" .. table.concat(selectedText, ".*\\n.*") .. ".*"
  end

  return { text = pattern_to_search, selection = selection }
end

return Chiruno.get_text_selection
