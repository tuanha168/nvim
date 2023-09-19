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

  local function checkNeoTree()
    local buffers = vim.fn.getwininfo()
    local haveNeoTree = false
    for _, buf in ipairs(buffers) do
      if string.find(vim.api.nvim_buf_get_name(buf.bufnr), "neo-tree", 1, true) ~= nil then
        haveNeoTree = true
        break
      end
    end

    if haveNeoTree then
      split:unmount()
    else
      split:unmount()
      split = Split(options)
      split:mount()
      vim.cmd.wincmd "p"
    end
  end

  autocmd({ "FileType" }, {
    pattern = Chiruno.constants.templateBuffer,
    callback = function() vim.opt_local.cursorline = false end,
    once = true,
  })

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = checkNeoTree,
    once = true,
  })

  autocmd("User", {
    pattern = Chiruno.constants.events.NeoTreeToggle,
    callback = checkNeoTree,
  })
end

function Chiruno.open_null_window() end

return Chiruno.null_window
