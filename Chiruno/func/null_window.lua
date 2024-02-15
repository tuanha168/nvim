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
  openNullWindow = false
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
  openNullWindow = true
  opts = Chiruno.func.extends_table({
    left = true,
    right = false,
  }, opts or {})

  local ok, Split = pcall(require, "nui.split")
  if not ok then return end

  if opts.left then
    if splitLeft then splitLeft:unmount() end

    splitLeft = Split(Chiruno.func.extends_table(options, {
      position = "left",
    }))

    splitLeft:mount()
  end

  if opts.right then
    if splitRight then splitRight:unmount() end

    splitRight = Split(Chiruno.func.extends_table(options, {
      position = "right",
    }))

    splitRight:mount()
  end
end

function Chiruno.func.toggle_null_window()
  openNullWindow = not openNullWindow

  Chiruno.func.check_null_window()
end

function Chiruno.func.check_null_window()
  if not openNullWindow then return Chiruno.func.close_null_window() end

  local buffers = vim.fn.getwininfo()
  if not buffers then return end
  local haveLeftPanel = false
  local haveRightPanel = false
  for _, buf in ipairs(buffers) do
    for _, ft in ipairs(Chiruno.constants.null_window.leftPanelIgnore) do
      if string.find(vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }), ft) then haveLeftPanel = true end
    end

    for _, ft in ipairs(Chiruno.constants.null_window.rightPanelIgnore) do
      if string.find(vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }), ft) then haveRightPanel = true end
    end
  end

  if haveLeftPanel then
    Chiruno.func.close_null_window { right = false }
  else
    Chiruno.func.open_null_window { right = false }
  end

  if haveRightPanel then
    Chiruno.func.close_null_window { left = false }
  else
    Chiruno.func.open_null_window { left = false }
  end
end

return Chiruno.func.check_null_window
