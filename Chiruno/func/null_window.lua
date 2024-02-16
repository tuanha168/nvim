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
---@param opts? NullWindowOptions
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
---@param opts NullWindowOptions
---@return nil
local function open_null_window(opts)
  openNullWindow = true

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

-- Check for ignore
---@param bufnr number
---@param opts? NullWindowOptionKeys
---@return boolean
function Chiruno.func.check_ignore_window(bufnr, opts)
  if not opts or opts == "left" then
    for _, ft in ipairs(Chiruno.constants.null_window.leftPanelIgnore) do
      if string.find(vim.api.nvim_get_option_value("filetype", { buf = bufnr }), ft) then return true end
    end
  end

  if not opts or opts == "right" then
    for _, ft in ipairs(Chiruno.constants.null_window.rightPanelIgnore) do
      if string.find(vim.api.nvim_get_option_value("filetype", { buf = bufnr }), ft) then return true end
    end
  end

  return false
end

---@param e? AutocmdCallbackEvent
function Chiruno.func.check_null_window(e)
  if e and (not e.match or e.match == "") then return end

  if not openNullWindow then return Chiruno.func.close_null_window() end

  local buffers = vim.fn.getwininfo()
  if not buffers then return end
  local haveLeftPanel = false
  local haveRightPanel = false
  for _, buf in ipairs(buffers) do
    if Chiruno.func.check_ignore_window(buf.bufnr, "left") then haveLeftPanel = true end

    if Chiruno.func.check_ignore_window(buf.bufnr, "right") then haveRightPanel = true end
  end

  ---@type NullWindowOptions
  local opts = { left = true, right = true }

  local ok, userConfig = pcall(require, "user.init")
  if ok then opts = Chiruno.func.extends_table(opts, userConfig.null_window or {}) end

  if haveLeftPanel then opts.left = false end

  if haveRightPanel then opts.right = false end

  Chiruno.func.close_null_window()

  if opts.left or opts.right then open_null_window(opts) end
end

return Chiruno.func.check_null_window
