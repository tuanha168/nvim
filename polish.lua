-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd("BufRead", {
    pattern = "*",
    callback = function() require "user.utils" end,
    once = true,
  })

  autocmd({ "BufRead" }, {
    pattern = "*",
    callback = function()
      -- vim.cmd "set laststatus&"
      vim.cmd "syntax sync fromstart"
    end,
  })

  autocmd({ "FocusGained", "BufRead" }, {
    pattern = "*",
    callback = function() vim.cmd "checktime" end,
  })

  autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.conf",
    callback = function() vim.cmd "setf dosini" end,
  })
end
