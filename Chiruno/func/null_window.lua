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

-- Get null window status
---@return {splitLeft?: boolean, splitRight?: boolean}
function Chiruno.func.get_null_window_status()
  local splitLeftBufnr = splitLeft and splitLeft.bufnr
  local splitRightBufnr = splitRight and splitRight.bufnr

  return { splitLeft = splitLeftBufnr and true, splitRight = splitRightBufnr and true }
end

-- Close null window
---@param opts? {left?: boolean, right?: boolean}
---@return nil
function Chiruno.func.close_null_window(opts)
  opts = Chiruno.func.extends_table({
    left = true,
    right = true,
  }, opts or {})

  if splitLeft and opts.left then splitLeft:unmount() end
  if splitRight and opts.right then splitRight:unmount() end
end

-- Open null window
---@param opts? {left?: boolean, right?: boolean}
---@return nil
function Chiruno.func.open_null_window(opts)
  opts = Chiruno.func.extends_table({
    left = true,
    right = true,
  }, opts or {})

  local ok, Split = pcall(require, "nui.split")
  if not ok then return end

  local buffers = vim.fn.getwininfo()
  local haveNeoTree = false
  local haveAerial = false

  if not buffers then return end

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }) == "neo-tree" then haveNeoTree = true end
    if vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }) == "aerial" then haveAerial = true end
  end

  if opts.left and not haveNeoTree then
    if splitLeft then splitLeft:unmount() end

    splitLeft = Split(Chiruno.func.extends_table(options, {
      position = "left",
    }))

    splitLeft:mount()
  end

  if opts.right and not haveAerial then
    if splitRight then splitRight:unmount() end

    splitRight = Split(Chiruno.func.extends_table(options, {
      position = "right",
    }))

    splitRight:mount()
  end
end

function Chiruno.func.toggle_null_window()
  openNullWindow = not openNullWindow

  if openNullWindow then
    Chiruno.func.open_null_window()
  else
    Chiruno.func.close_null_window()
  end
end

function Chiruno.func.check_null_window()
  local buffers = vim.fn.getwininfo()
  if not buffers then return end
  local haveNeoTree = false
  local haveAerial = false
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }) == "neo-tree" then haveNeoTree = true end
    if vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }) == "aerial" then haveAerial = true end
    if string.find(vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }), "dapui") then haveAerial = true end
  end

  if haveNeoTree then
    Chiruno.func.close_null_window { right = false }
  elseif openNullWindow then
    Chiruno.func.open_null_window { right = false }
  end

  if haveAerial then
    Chiruno.func.close_null_window { left = false }
  elseif openNullWindow then
    Chiruno.func.open_null_window { left = false }
  end
end

return Chiruno.func.check_null_window
