function Chiruno.motions.format_motion(motion_type)
  local selection = Chiruno.func.get_selection(motion_type)
  local range = nil
  if selection ~= nil then
    range = {
      ["start"] = { selection.startRow, selection.startCol },
      ["end"] = { selection.finishRow, selection.finishCol },
    }
  end

  vim.lsp.buf.format({ range = range })
end

return Chiruno.motions.format_motion
