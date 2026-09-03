local M = {}

local SPAWN_TIMEOUT_MS = 30000
local CONNECT_TIMEOUT_MS = 5000
local POLL_INTERVAL_MS = 500

local function start_server()
  vim.fn.system("opencode-spawn " .. vim.fn.shellescape(vim.fn.getcwd()))
end

local function find_opencode_pane_pid()
  if vim.env.TMUX then
    local panes = vim.fn.system "tmux list-panes -F '#{pane_pid} #{pane_current_command}'"
    for line in panes:gmatch "[^\r\n]+" do
      local pid, cmd = line:match "^(%d+)%s+(.+)$"
      if cmd == "opencode" then return tonumber(pid) end
    end
    for line in panes:gmatch "[^\r\n]+" do
      local pid, cmd = line:match "^(%d+)%s+(.+)$"
      if cmd == "claude" then return tonumber(pid), "claude" end
    end
  elseif vim.env.HERDR_ENV then
    local out = vim.fn.system("herdr-opencode-pid 2>/dev/null"):gsub("%s+$", "")
    if out ~= "" then return tonumber(out:match "^(%d+)") end
    local pid = vim.fn.system("herdr-claude-pid 2>/dev/null"):gsub("%s+$", "")
    if pid ~= "" then return tonumber(pid), "claude" end
  end
  return nil
end

local herdr_cached_port = nil

local function resolve_opencode_pid(pane_pid)
  local child = vim.fn.system(string.format("pgrep -P %d opencode", pane_pid)):gsub("%s+$", "")
  if child ~= "" then return tonumber(child:match "^(%d+)") end
  local cmdline = vim.fn.system(string.format("ps -p %d -o args=", pane_pid)):gsub("%s+$", "")
  if cmdline:match "opencode" then return pane_pid end
  return nil
end

local function get_port_for_pid(pid)
  local out = vim.fn.system(string.format("lsof -Fpn -w -iTCP -sTCP:LISTEN -p %d -a -P -n", pid))
  return tonumber(out:match ":(%d+)\n")
end

local function find_opencode_pid_in_window()
  local pane_pid, tool = find_opencode_pane_pid()
  if not pane_pid then return nil, nil end
  if tool == "claude" then return pane_pid, "claude" end
  if vim.env.HERDR_ENV then
    local out = vim.fn.system("herdr-opencode-pid 2>/dev/null"):gsub("%s+$", "")
    local pid_str, port_str = out:match "^(%d+)%s+(%d+)$"
    if pid_str and port_str then
      herdr_cached_port = tonumber(port_str)
      return tonumber(pid_str), "opencode"
    end
    herdr_cached_port = nil
    return nil, nil
  end
  local opencode_pid = resolve_opencode_pid(pane_pid)
  if not opencode_pid then return nil, nil end
  return opencode_pid, "opencode"
end

local function get_port(pid)
  if vim.env.HERDR_ENV and herdr_cached_port then
    return herdr_cached_port
  end
  return get_port_for_pid(pid)
end

local function is_connected() return next(require("sidekick.cli.session").attached()) ~= nil end

local function wait_for_connected_server(timeout)
  return vim.wait(timeout, function() return is_connected() end, 100)
end

local function poll_for_pid_in_window(timeout_ms, interval_ms, on_found, on_timeout)
  local timer = vim.uv.new_timer()
  if not timer then
    on_timeout()
    return
  end
  local elapsed = 0
  timer:start(
    0,
    interval_ms,
    vim.schedule_wrap(function()
      local pid, tool = find_opencode_pid_in_window()
      local port = pid and get_port(pid) or nil
      if tool == "claude" then
        timer:stop()
        timer:close()
        on_found(pid, 0)
        return
      end
      if pid and port then
        timer:stop()
        timer:close()
        on_found(pid, port)
        return
      end
      elapsed = elapsed + interval_ms
      if elapsed >= timeout_ms then
        timer:stop()
        timer:close()
        on_timeout()
      end
    end)
  )
end

-- Connect to a specific pid, bypassing cwd-based server selection.
local function connect_to_pid(pid, port)
  local Session = require "sidekick.cli.session"
  local base_url = ("http://localhost:%d"):format(port)
  local session = Session.new {
    id = "opencode-" .. pid,
    pid = pid,
    tool = "opencode",
    pids = { pid },
    mux_session = tostring(pid),
    base_url = base_url,
    backend = "opencode",
    started = true,
  }

  local State = require "sidekick.cli.state"
  State.attach { session = session, tool = session.tool }
end

function M.ensure_server()
  if is_connected() then return end

  if vim.env.TMUX == nil and vim.env.HERDR_ENV == nil then return end

  local pid, tool = find_opencode_pid_in_window()
  if tool == "claude" then return end

  local port = pid and get_port(pid) or nil
  if not port then
    start_server()
    poll_for_pid_in_window(
      SPAWN_TIMEOUT_MS,
      POLL_INTERVAL_MS,
      connect_to_pid,
      function() vim.notify("Timeout waiting for opencode server to start", vim.log.levels.WARN, { title = "opencode" }) end
    )
    return
  end

  connect_to_pid(pid, port)
end

function M.ensure_server_sync()
  if is_connected() then return true end

  if vim.env.TMUX == nil and vim.env.HERDR_ENV == nil then return true end

  local pid, tool = find_opencode_pid_in_window()
  if tool == "claude" then return true end

  local port = pid and get_port(pid) or nil
  if not port then
    start_server()
    local elapsed = 0
    while not port and elapsed < SPAWN_TIMEOUT_MS do
      vim.loop.sleep(POLL_INTERVAL_MS)
      elapsed = elapsed + POLL_INTERVAL_MS
      pid, tool = find_opencode_pid_in_window()
      if tool == "claude" then return true end
      port = pid and get_port(pid) or nil
    end
  end

  if not port then
    vim.notify("Timeout waiting for opencode server to start", vim.log.levels.WARN, { title = "opencode" })
    return false
  end

  connect_to_pid(pid, port)

  local success = wait_for_connected_server(CONNECT_TIMEOUT_MS)
  if not success then vim.notify("Timeout waiting for opencode server", vim.log.levels.WARN, { title = "opencode" }) end
  return success
end

return M
