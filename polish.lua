-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd("BufRead", {
    pattern = "*",
    callback = function()
      require "user.Chiruno"
      vim.diagnostic.config { virtual_text = true }
    end,
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

  autocmd("BufWrite", {
    pattern = "*.norg",
    callback = function()
      if Chiruno.file_exists(os.getenv "HOME" .. "/neorg/scripts/autoupdate.sh") then
        vim.cmd 'silent exec "!${HOME}/neorg/scripts/autoupdate.sh &"'
      end
    end,
  })
end
