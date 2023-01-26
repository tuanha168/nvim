local M = {}

M.setup = function()
  local ok, lsp_signature = pcall(require, "lsp_signature")
  if not ok then
    return
  end

  lsp_signature.setup {
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
end
return M
