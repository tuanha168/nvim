function Chiruno.motions.format_motion(motion_type)
  local selection = Chiruno.func.get_selection(motion_type)
  local range = nil
  if selection ~= nil then
    range = {
      ["start"] = { selection.startRow, selection.startCol },
      ["end"] = { selection.finishRow, selection.finishCol },
    }
  end

  local formatOpts = require "lsp.format"
  formatOpts.range = range
  vim.lsp.buf.format(formatOpts)
end

return Chiruno.motions.format_motion
