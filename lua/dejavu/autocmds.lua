local autocmd = vim.api.nvim_create_autocmd

autocmd("BufRead", {
  pattern = "*",
  callback = function() require "Chiruno" end,
  once = true,
})

autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    -- vim.cmd "set laststatus&"
    vim.cmd "syntax sync fromstart"
  end,
})

autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function() vim.cmd "checktime" end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.conf",
  callback = function() vim.cmd "setf dosini" end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*.norg",
  callback = function() Chiruno.auto_push "~/neorg" end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  callback = function(event)
    if string.match(event.file, os.getenv "HOME" .. "/.config/nvim/lua/user") then
      Chiruno.auto_push "~/.config/nvim/lua/user"
    end

    if string.match(event.file, os.getenv "HOME" .. "/.dotfile") then Chiruno.auto_push "~/.dotfile" end
  end,
})
