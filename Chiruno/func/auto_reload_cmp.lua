function Chiruno.auto_reload_cmp()
  local autocmd = vim.api.nvim_create_autocmd
  local timer

  if vim.uv then
    timer = vim.uv.new_timer()
  else
    timer = vim.loop.new_timer()
  end

  timer:start(
    500,
    500,
    vim.schedule_wrap(function()
      timer:stop()
      local ok, cmp = pcall(require, "cmp")
      if not ok then return end

      cmp.complete()
    end)
  )
  timer:stop()

  autocmd({ "InsertEnter", "InsertCharPre" }, {
    pattern = "*",
    callback = function() timer:again() end,
  })

  autocmd({ "InsertLeave" }, {
    pattern = "*",
    callback = function() timer:stop() end,
  })
end

return Chiruno.auto_reload_cmp
