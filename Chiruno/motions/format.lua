Chiruno.format_motion = function()
  local opts = require("astronvim.utils.lsp").format_opts
  local selection = Chiruno.get_selection()
  if selection ~= nil then
    opts.range = {
      ["start"] = { selection.startRow - 5, selection.startCol },
      ["end"] = { selection.finishRow - 5, selection.finishCol },
    }
  end

  Chiruno.print(opts.range)

  vim.lsp.buf.format(opts)
end
