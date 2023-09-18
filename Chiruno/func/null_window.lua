Chiruno = Chiruno or {}

function Chiruno.null_window()
  local autocmd = vim.api.nvim_create_autocmd
  local Split = require "nui.split"

  local highlights = require "neo-tree.ui.highlights"
  local split = Split {
    ns_id = highlights.ns_id,
    relative = "editor",
    position = "left",
    size = "20%",
    buf_options = {
      buftype = "nofile",
      modifiable = false,
      swapfile = false,
      filetype = "neo-tree",
      undolevels = -1,
    },
    win_options = {
      colorcolumn = "",
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  }

  -- mount/open the component
  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(e)
      if not e.match or e.match == "" then return end
      require "user.Chiruno.func.print"(e.match)
      split:mount()
    end,
  })

  autocmd("User", {
    pattern = "ChirunoNeotreeToggle",
    callback = function(e)
      if vim.api.nvim_buf_is_valid(e.buf) then
        local bufName = vim.api.nvim_buf_get_name(e.buf)
        if string.find(bufName, "neo-tree", 1, true) ~= nil then
          split:unmount()
        else
          split:mount()
          -- vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), e.buf)
        end
      end
    end,
    group = vim.api.nvim_create_augroup("NeoTree", { clear = true }),
  })
end

return Chiruno.null_window
