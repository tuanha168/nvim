local autocmd = vim.api.nvim_create_autocmd
local timer

function Chiruno.auto_reload_cmp()
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

function Chiruno.get_auto_reload_cmp_timer() return timer end

return Chiruno.auto_reload_cmp
