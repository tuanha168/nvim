return {
  floating_window = false,
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
  hint_enable = false,
  -- hint_prefix = " ",
  -- hint_scheme = "LspSignatureHintVirtualText",
  toggle_key = "<C-x>",
}
