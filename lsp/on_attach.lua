local signature_setup = {
  floating_window = true,
  bind = true,
  hint_enable = false,
  handler_opts = {
    border = "rounded",
  },
  always_trigger = false,
  toggle_key = "<C-z>i",
  toggle_key_flip_floatwin_setting = true
}

return function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then vim.lsp.buf.inlay_hint(bufnr, true) end
  require("lsp_signature").on_attach(signature_setup, bufnr)
end
