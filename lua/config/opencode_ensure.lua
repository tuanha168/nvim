local M = {}

local START_TIMEOUT_MS = 30000
local POLL_INTERVAL_MS = 500

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.WARN, { title = "opencode" })
end

local function sh(cmd)
  return vim.fn.system(cmd):gsub("%s+$", "")
end

local function in_multiplexer()
  return vim.env.TMUX ~= nil or vim.env.HERDR_ENV ~= nil
end

local function json_decode(out)
  local ok, res = pcall(vim.json.decode, out)
  return ok and res or nil
end

local function tmux_target()
  local panes = vim.fn.system "tmux list-panes -F '#{pane_id} #{pane_current_command}'"
  local claude
  for line in panes:gmatch "[^\r\n]+" do
    local pane_id, cmd = line:match "^(%S+)%s+(.+)$"
    if cmd == "opencode" then return pane_id end
    if cmd == "claude" then claude = claude or pane_id end
  end
  return claude
end

local function herdr_panes()
  local res = json_decode(sh "herdr pane list 2>/dev/null")
  return res and res.result and res.result.panes or {}
end

local function herdr_target()
  local panes = herdr_panes()
  local current = json_decode(sh "herdr pane current 2>/dev/null")
  if not current or not current.result or not current.result.pane then return nil end
  local me = current.result.pane

  for _, pane in ipairs(panes) do
    if pane.agent == "opencode" or pane.agent == "claude" then
      if pane.tab_id == me.tab_id then return pane.pane_id end
    end
  end
  return nil
end

local function find_target()
  if not in_multiplexer() then return nil end
  if vim.env.TMUX then return tmux_target() end
  return herdr_target()
end

local function start_agent()
  sh("opencode-spawn " .. vim.fn.shellescape(vim.fn.getcwd()))
end

local function wait_for_target(timeout_ms, on_found, on_timeout)
  local elapsed = 0
  local timer = vim.uv.new_timer()
  if not timer then
    return on_timeout()
  end
  timer:start(
    0,
    POLL_INTERVAL_MS,
    vim.schedule_wrap(function()
      local target = find_target()
      if target then
        timer:stop()
        timer:close()
        return on_found(target)
      end
      elapsed = elapsed + POLL_INTERVAL_MS
      if elapsed >= timeout_ms then
        timer:stop()
        timer:close()
        on_timeout()
      end
    end)
  )
end

local function send_text(target, text)
  if vim.env.TMUX then
    local buffer = "opencode-send-" .. target
    local out = vim.fn.system({ "tmux", "load-buffer", "-b", buffer, "-" }, text)
    if vim.v.shell_error ~= 0 then
      notify("Failed to load tmux buffer: " .. out, vim.log.levels.ERROR)
      return false
    end
    out = vim.fn.system({ "tmux", "paste-buffer", "-b", buffer, "-d", "-r", "-p", "-t", target })
    if vim.v.shell_error ~= 0 then
      notify("Failed to paste into tmux pane: " .. out, vim.log.levels.ERROR)
      return false
    end
    return true
  end
  local out = vim.fn.system({ "herdr", "pane", "send-text", target, text })
  if vim.v.shell_error ~= 0 then
    notify("Failed to send to herdr pane: " .. out, vim.log.levels.ERROR)
    return false
  end
  return true
end

local function buf_name()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then return "[No Name]" end
  local cwd = vim.fn.getcwd(0)
  local ok, rel = pcall(vim.fs.relpath, cwd, name)
  if ok and rel and rel ~= "" and rel ~= "." then return rel end
  return name
end

local function render_location()
  local ret = "@" .. buf_name()

  local mode = vim.fn.mode()
  if mode:match "^[vV\22]" then
    local from_line = vim.fn.line "v"
    local to_line = vim.fn.line "."
    if from_line > to_line then
      from_line, to_line = to_line, from_line
    end
    ret = ret .. " :L" .. from_line
    if from_line ~= to_line then ret = ret .. "-L" .. to_line end
    return ret
  end

  return ret .. " :L" .. vim.fn.line "."
end

function M.send(opts)
  opts = opts or {}
  if not in_multiplexer() then
    notify "No tmux or herdr session detected"
    return false
  end

  local text = opts.msg or render_location()
  if text == "" then
    notify "Nothing to send"
    return false
  end

  local target = find_target()
  if not target then
    start_agent()
    wait_for_target(START_TIMEOUT_MS, function(found)
      send_text(found, text)
    end, function() notify "Timeout waiting for opencode pane to start" end)
    return true
  end

  return send_text(target, text)
end

return M
