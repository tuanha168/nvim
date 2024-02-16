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
      for _, ft in ipairs(Chiruno.constants.null_window.leftPanelIgnore) do
        if string.find(vim.api.nvim_get_option_value("filetype", { buf = e.bufnr }), ft) then
          vim.schedule(Chiruno.func.check_null_window)
          break
        end
      end

      for _, ft in ipairs(Chiruno.constants.null_window.rightPanelIgnore) do
        if string.find(vim.api.nvim_get_option_value("filetype", { buf = e.bufnr }), ft) then
          vim.schedule(Chiruno.func.check_null_window)
          break
        end
      end
    end,
  })

  autocmd("User", {
    pattern = Chiruno.constants.events.ToggleWindow,
    callback = Chiruno.func.check_null_window,
  })
end

return Chiruno.autocmd.null_window
