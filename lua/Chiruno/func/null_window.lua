local openNullWindow = true

local options = {
  relative = "editor",
  size = Chiruno.constants.nullWindowSize,
  enter = false,
  buf_options = {
    buftype = "nofile",
    modifiable = false,
    swapfile = false,
    filetype = Chiruno.constants.nullWindowName,
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

---@class NuiSplit
local splitLeft
---@class NuiSplit
local splitRight

---@param win number
---@return boolean?
local function is_float(win)
  local opts = vim.api.nvim_win_get_config(win)
  return opts and opts.relative and opts.relative ~= ""
end

---@param win? number
---@return boolean?
local function is_only_one_window(win)
  local count = 0
  for _, _win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if
      ((splitLeft and _win ~= splitLeft.winid) or (splitRight and _win ~= splitRight.winid))
      and not is_float(_win)
      and (not win or win ~= _win)
    then
      count = count + 1
    end
  end
  return count <= 1
end

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
function Chiruno.func.open_null_window(opts)
  openNullWindow = true

  local current_bufnr = vim.api.nvim_get_current_buf()

  if opts.left then
    if splitLeft then splitLeft:unmount() end

    vim.schedule(function() splitLeft:mount() end)
  end

  if opts.right then
    if splitRight then splitRight:unmount() end

    vim.schedule(function() splitRight:mount() end)
  end

  vim.api.nvim_win_set_buf(0, current_bufnr)
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

---@param e? vim.api.keyset.create_autocmd.callback_args
---@param closedWin? number
function Chiruno.func.check_null_window(e, closedWin)
  if e and (not e.match or e.match == "") then return end

  if not openNullWindow then return Chiruno.func.close_null_window() end

  local buffers = vim.fn.getwininfo()
  if not buffers then return end
  local haveLeftPanel = false
  local haveRightPanel = false
  for _, buf in ipairs(buffers) do
    if buf.winid == closedWin then goto continue end

    if Chiruno.func.check_ignore_window(buf.bufnr, "left") then haveLeftPanel = true end

    if Chiruno.func.check_ignore_window(buf.bufnr, "right") then haveRightPanel = true end
    ::continue::
  end

  ---@type NullWindowOptions
  local opts = { left = true, right = true }

  local ok, userConfig = pcall(require, "config")
  if ok then opts = Chiruno.func.extends_table(opts, userConfig.null_window or {}) end

  if haveLeftPanel then opts.left = false end

  if haveRightPanel then opts.right = false end

  Chiruno.func.close_null_window()

  if opts.left or opts.right then Chiruno.func.open_null_window(opts) end
end

---@param e? vim.api.keyset.create_autocmd.callback_args
function Chiruno.func.on_null_win_enter(e)
  if not e then return end

  if e.event == "WinClosed" then
    local closedWin = tonumber(e.match)
    if closedWin and is_float(closedWin) then return end

    -- if is_only_one_window(closedWin) then
    Chiruno.func.check_null_window(e, closedWin)
    -- end
    return
  end

  local win = vim.api.nvim_get_current_win()
  if is_float(win) then return end

  -- if not is_only_one_window() then
  -- Chiruno.func.close_null_window()
  -- end
  Chiruno.func.check_null_window()
end

function Chiruno.func.setup_null_window()
  local ok, Split = pcall(require, "nui.split")
  if not ok then return end

  ---@class NuiSplit
  splitLeft = Split(Chiruno.func.extends_table(options, {
    position = "left",
  }))

  ---@class NuiSplit
  splitRight = Split(Chiruno.func.extends_table(options, {
    position = "right",
  }))
end

return Chiruno.func.check_null_window
