Chiruno.format_motion = function()
  local opts = require("astronvim.utils.lsp").format_opts
  local selection = Chiruno.get_selection()
  local range = nil
  if selection ~= nil then
    range = {
      ["start"] = { selection.startRow, selection.startCol },
      ["end"] = { selection.finishRow, selection.finishCol },
    }
  end

  vim.lsp.buf.format(vim.tbl_deep_extend("force", opts, { range = range }))
end
