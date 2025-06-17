function Chiruno.motions.console_log(mode)
  local textSelection = Chiruno.func.get_text_selection(mode)
  if not textSelection then return end

  local text, selection = textSelection.text, textSelection.selection
  if text == nil then return end
  if mode == "line" and selection.finishRow - selection.startRow ~= 0 then return end

  Chiruno.func.feedkeys("oconsole.log('debug: " .. text .. "', ".. text.. ")<ESC>", "n")
end

return Chiruno.motions.console_log
