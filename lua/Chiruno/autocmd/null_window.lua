function Chiruno.autocmd.null_window()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = Chiruno.func.check_null_window,
    once = true,
  })

  autocmd({ "BufWipeout" }, {
    pattern = "*",
    callback = Chiruno.func.check_null_window,
  })

  autocmd("User", {
    pattern = Chiruno.constants.events.ToggleWindow,
    callback = Chiruno.func.check_null_window,
  })

  vim.keymap.set("n", "<Leader>z", Chiruno.func.toggle_null_window, { desc = "Toggle Null Window", noremap = true })
end

return Chiruno.autocmd.null_window
