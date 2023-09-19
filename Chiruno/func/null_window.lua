Chiruno = Chiruno or {}

function Chiruno.null_window()
  local autocmd = vim.api.nvim_create_autocmd
  local Split = require "nui.split"

  local options = {
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

  local split = Split(options)

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
    callback = function()
      local buffers = vim.fn.getwininfo()
      local haveNeoTree = false
      for _, buf in ipairs(buffers) do
        Chiruno.print(vim.api.nvim_buf_get_name(buf.bufnr))
        if string.find(vim.api.nvim_buf_get_name(buf.bufnr), "neo-tree", 1, true) ~= nil then
          haveNeoTree = true
          break
        end
      end

      if haveNeoTree then
        split:unmount()
      else
        split = Split(options)
        split:mount()
        vim.cmd.wincmd "p"
      end
    end,
  })
end

return Chiruno.null_window
