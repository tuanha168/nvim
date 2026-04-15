local M = {}

local function start_server()
  local cwd = vim.fn.getcwd()
  local pane_id = vim.fn.system(
    string.format("tmux split-window -d -P -F '#{pane_id}' -h -l 35%% -c %q 'opencode --port'", cwd)
  )
  pane_id = vim.trim(pane_id)
  if pane_id ~= "" then
    vim.fn.system(string.format("tmux set-option -t %s -p allow-passthrough off", pane_id))
  end
end

local function find_opencode_server_pid()
  -- list-panes without -a = current window only
  local panes = vim.fn.system("tmux list-panes -F '#{pane_pid} #{pane_current_command}'")
  for line in panes:gmatch("[^\r\n]+") do
    local pid, cmd = line:match("^(%d+)%s+(.+)$")
    if cmd == "opencode" then
      -- pane_current_command = "opencode" when user ran it manually (shell child)
      -- or when nvim spawned it directly. Either way, opencode is running here.
      return tonumber(pid)
    end
    -- fallback: pane replaced its shell with opencode --port (nvim-spawned)
    if pid then
      local cmdline = vim.fn.system(string.format("ps -p %s -o args=", pid)):gsub("%s+$", "")
      if cmdline:match("opencode.*%-%-port") then
        return tonumber(pid)
      end
    end
  end
  return nil
end

local function is_connected(events)
  return events.connected_server ~= nil
end

local function wait_for_connected_server(events, timeout)
  return vim.wait(timeout, function()
    return is_connected(events)
  end, 100)
end

local function sleep(ms)
  vim.loop.sleep(ms)
end

local function connect()
  require("opencode.server").get(false):next(function(server)
    vim.notify("Connected to opencode server (port " .. server.port .. ")", vim.log.levels.INFO, { title = "opencode" })
  end):catch(function(err)
    vim.notify("Failed to connect to opencode server: " .. err, vim.log.levels.WARN, { title = "opencode" })
  end)
end

local function start_default_split()
  require("opencode.server").get(true)
end

function M.ensure_server()
  local events = require("opencode.events")
  if is_connected(events) then
    return
  end

  if vim.env.TMUX == nil then
    start_default_split()
    return
  end

  if not find_opencode_server_pid() then
    start_server()
    vim.defer_fn(connect, 2000)
    return
  end

  connect()
end

function M.ensure_server_sync(timeout)
  timeout = timeout or 5000
  local events = require("opencode.events")
  if is_connected(events) then
    return true
  end

  if vim.env.TMUX == nil then
    start_default_split()
    return true
  end

  if not find_opencode_server_pid() then
    start_server()
    sleep(5000)
  end

  connect()

  local success = wait_for_connected_server(events, timeout)
  if not success then
    vim.notify("Timeout waiting for opencode server", vim.log.levels.WARN, { title = "opencode" })
  end
  return success
end

return M
