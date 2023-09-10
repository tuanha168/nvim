local signature_setup = {
  floating_window = false,
  bind = true,
  hint_enable = false,
  handler_opts = {
    border = "rounded",
  },
  always_trigger = true,
  toggle_key = "<C-z>i",
  toggle_key_flip_floatwin_setting = true,
}

return function(client, bufnr)
  if client.server_capabilities.workspace then
    client.server_capabilities.workspace.didChangeWatchedFiles = client.server_capabilities.workspace.didChangeWatchedFiles
      or {}
    client.server_capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }
  end
  if client.server_capabilities.inlayHintProvider then
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint(bufnr, true)
    else
      vim.lsp.buf.inlay_hint(bufnr, true)
    end
  end
  require("lsp_signature").on_attach(signature_setup, bufnr)
  Chiruno.print(client)

  if client.name == "rust_analyzer" then
    local rt = require "rust-tools"
    vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
  end
end
