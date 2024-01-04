function Chiruno.autocmd.null_window()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = Chiruno.func.check_null_window,
    once = true,
  })

  autocmd("User", {
    pattern = Chiruno.func.parse_from_table(Chiruno.constants.events, "values"),
    callback = Chiruno.func.check_null_window,
  })
end

return Chiruno.autocmd.null_window
