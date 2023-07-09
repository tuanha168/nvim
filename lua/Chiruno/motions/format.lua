Chiruno.format_motion = function()
  local opts = require("lsp.formatting")
  local selection = Chiruno.get_selection()
  if selection ~= nil then
    opts.range = {
      ["start"] = { selection.startRow, selection.startCol },
      ["end"] = { selection.finishRow, selection.finishCol },
    }
  end

  vim.lsp.buf.format(opts)
end
