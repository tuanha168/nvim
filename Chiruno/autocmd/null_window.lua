function Chiruno.autocmd.null_window()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = Chiruno.func.check_null_window,
    once = true,
  })

  autocmd({ "BufLeave" }, {
    pattern = "*",
    callback = function(e)
      Print(e)
      -- vim.defer_fn(Chiruno.func.check_null_window, 500)
    end,
  })

  autocmd("User", {
    pattern = Chiruno.constants.events.ToggleWindow,
    callback = Chiruno.func.check_null_window,
  })
end

return Chiruno.autocmd.null_window
