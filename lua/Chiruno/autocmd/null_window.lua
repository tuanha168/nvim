function Chiruno.autocmd.null_window()
  Chiruno.func.setup_null_window()

  local null_window_augroup = vim.api.nvim_create_augroup("NullWindow", { clear = true })

  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
    pattern = "*",
    callback = Chiruno.func.check_null_window,
    group = null_window_augroup,
    once = true,
  })

  autocmd({  "WinClosed" }, {
    pattern = "*",
    callback = Chiruno.func.on_null_win_enter,

    group = null_window_augroup,
  })

  vim.keymap.set("n", "<Leader>z", Chiruno.func.toggle_null_window, { desc = "Toggle Null Window", noremap = true })
end

return Chiruno.autocmd.null_window
