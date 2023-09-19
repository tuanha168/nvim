Chiruno = Chiruno or {}

function Chiruno.null_window()
  local autocmd = vim.api.nvim_create_autocmd
  local Split = require "nui.split"

  local split = Split {
    relative = "editor",
    position = "left",
    size = Chiruno.constants.templateBufferSize,
    buf_options = {
      buftype = "nofile",
      modifiable = false,
      swapfile = false,
      filetype = Chiruno.constants.templateBuffer,
      undolevels = -1,
    },
    win_options = {
      colorcolumn = "",
      number = false,
      relativenumber = false,
      signcolumn = "no",
      cursorline = false,
    },
  }

  autocmd({ "FileType" }, {
    pattern = Chiruno.constants.templateBuffer,
    callback = function() vim.opt_local.cursorline = false end,
    once = true,
  })

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(e)
      if not e.match or e.match == "" then return end
      split:mount()
      Chiruno.feedkeys("<C-w>l", "n")
    end,
    once = true,
  })

  autocmd("User", {
    pattern = Chiruno.constants.events.NeoTreeToggle,
    callback = function(e)
      if vim.api.nvim_buf_is_valid(e.buf) then
        local bufName = vim.api.nvim_buf_get_name(e.buf)
        if string.find(bufName, "neo-tree", 1, true) ~= nil then
          split:hide()
        else
          split:show()
          vim.cmd.wincmd "p"
        end
      end
    end,
  })
end

return Chiruno.null_window
