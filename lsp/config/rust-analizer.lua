return {
  on_attach = function(_, bufnr)
    local rt = require "rust-tools"
    vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
  end,
}
