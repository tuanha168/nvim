function Chiruno.autocmd.null_window()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = Chiruno.func.check_null_window,
    once = true,
  })

  local a,c = ipairs(Chiruno.constants.events)
  autocmd("User", {
    pattern = ,
    callback = Chiruno.func.check_null_window,
  })
end

return Chiruno.autocmd.null_window
