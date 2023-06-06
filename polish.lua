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

  autocmd("BufWritePost", {
    pattern = "*.norg",
    callback = function()
      if vim.fn.executable "git-auto-push" == 1 then
        vim.cmd 'silent exec "!git-auto-push ~/neorg &"'
        Chiruno.print "Auto Pushing"
      end
    end,
  })

  autocmd("BufWritePost", {
    pattern = "*.lua",
    callback = function(event)
      if
        vim.fn.executable "git-auto-push" == 1
        and string.match(event.file, os.getenv "HOME" .. "/.config/nvim/lua/user")
      then
        vim.cmd 'silent exec "!git-auto-push ~/.config/nvim/lua/user &"'
        Chiruno.print "Auto Pushing"
      end
    end,
  })
end
