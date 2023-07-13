Chiruno.format_motion = function()
  local opts = require("astronvim.utils.lsp").format_opts
  local selection = Chiruno.get_selection()
  if selection ~= nil then
    opts.range = {
      ["start"] = { selection.startRow + 1, selection.startCol + 1 },
      ["end"] = { selection.finishRow - 1, selection.finishCol - 1 },
    }
  end

  Chiruno.print(opts.range)

  vim.lsp.buf.format(opts)
end
