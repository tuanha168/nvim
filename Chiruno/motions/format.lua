Chiruno.format_motion = function()
  local opts = require("astronvim.utils.lsp").format_opts
  local selection = Chiruno.get_selection()
  if selection ~= nil then
    opts.range = {
      ["start"] = { selection.startRow, selection.startCol - 1 },
      ["end"] = { selection.finishRow, selection.finishCol - 1 },
    }
  end

  vim.lsp.buf.format(opts)
end
