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
  if client.supports_method "textDocument/codeLens" then
    Chiruno.add_buffer_autocmd("lsp_codelens_refresh", bufnr, {
      events = { "InsertLeave", "BufEnter" },
      desc = "Refresh codelens",
      callback = function()
        if not Chiruno.has_capability("textDocument/codeLens", { bufnr = bufnr }) then
          Chiruno.del_buffer_autocmd("lsp_codelens_refresh", bufnr)
          return
        end
        vim.lsp.codelens.refresh()
      end,
    })
  end
  if client.supports_method "textDocument/documentHighlight" then
    Chiruno.add_buffer_autocmd("lsp_document_highlight", bufnr, {
      {
        events = { "CursorHold", "CursorHoldI" },
        desc = "highlight references when cursor holds",
        callback = function()
          if not Chiruno.has_capability("textDocument/documentHighlight", { bufnr = bufnr }) then
            Chiruno.del_buffer_autocmd("lsp_document_highlight", bufnr)
            return
          end
          vim.lsp.buf.document_highlight()
        end,
      },
      {
        events = { "CursorMoved", "CursorMovedI" },
        desc = "clear references when cursor moves",
        callback = function() vim.lsp.buf.clear_references() end,
      },
    })
  end

  if client.server_capabilities.inlayHintProvider then vim.lsp.buf.inlay_hint(bufnr, true) end
  require("lsp_signature").on_attach(signature_setup, bufnr)

  if client.name == "rust_analyzer" then
    local rt = require "rust-tools"
    vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
  end
end
