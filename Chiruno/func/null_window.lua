Chiruno = Chiruno or {}

local splitLeft
local splitRight
local openNullWindow = true

local options = {
  relative = "editor",
  size = Chiruno.constants.templateBufferSize,
  enter = false,
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
    -- fillchars = { eob = " " },
  },
}

-- Close null window
---@param opts? {left?: boolean, right?: boolean}
---@return nil
function Chiruno.close_null_window(opts)
  opts = Chiruno.extends_table({
    left = true,
    right = true,
  }, opts or {})

  if splitLeft and opts.left then splitLeft:unmount() end
  if splitRight and opts.right then splitRight:unmount() end
end

-- Open null window
---@param opts? {left?: boolean, right?: boolean}
---@return nil
function Chiruno.open_null_window(opts)
  opts = Chiruno.extends_table({
    left = true,
    right = true,
  }, opts or {})

  local ok, Split = pcall(require, "nui.split")
  if not ok then return end

  if opts.left then
    if splitLeft then splitLeft:unmount() end

    splitLeft = Split(Chiruno.extends_table(options, {
      position = "left",
    }))

    splitLeft:mount()
  end

  if opts.right then
    if splitRight then splitRight:unmount() end

    splitRight = Split(Chiruno.extends_table(options, {
      position = "right",
    }))

    splitRight:mount()
  end
end

function Chiruno.toggle_null_window()
  openNullWindow = not openNullWindow

  if openNullWindow then
    Chiruno.open_null_window()
  else
    Chiruno.close_null_window()
  end
end

local function checkNullWindow()
  local buffers = vim.fn.getwininfo()
  local haveNeoTree = false
  local haveAerial = false
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_get_option(buf.bufnr, "filetype") == "neo-tree" then haveNeoTree = true end
    if vim.api.nvim_buf_get_option(buf.bufnr, "filetype") == "aerial" then haveAerial = true end
  end

  if haveNeoTree then
    Chiruno.close_null_window { right = false }
  elseif openNullWindow then
    Chiruno.open_null_window { right = false }
  end

  if haveAerial then
    Chiruno.close_null_window { left = false }
  elseif openNullWindow then
    Chiruno.open_null_window { left = false }
  end
end

function Chiruno.null_window()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = checkNullWindow,
    once = true,
  })

  autocmd("User", {
    pattern = { Chiruno.constants.events.NeoTreeToggle, Chiruno.constants.events.AerialToggle },
    callback = checkNullWindow,
  })
end

return Chiruno.null_window
