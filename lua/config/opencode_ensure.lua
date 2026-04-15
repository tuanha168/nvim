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

local function find_opencode_pane_pid()
  local panes = vim.fn.system("tmux list-panes -F '#{pane_pid} #{pane_current_command}'")
  for line in panes:gmatch("[^\r\n]+") do
    local pid, cmd = line:match("^(%d+)%s+(.+)$")
    if cmd == "opencode" then
      return tonumber(pid)
    end
  end
  return nil
end

-- pane_pid may be the shell (user-spawned) or opencode itself (nvim-spawned).
-- Resolve to the actual opencode pid either way.
local function resolve_opencode_pid(pane_pid)
  local child = vim.fn.system(string.format("pgrep -P %d opencode", pane_pid)):gsub("%s+$", "")
  if child ~= "" then
    return tonumber(child:match("^(%d+)"))
  end
  local cmdline = vim.fn.system(string.format("ps -p %d -o args=", pane_pid)):gsub("%s+$", "")
  if cmdline:match("opencode") then
    return pane_pid
  end
  return nil
end

local function get_port_for_pid(pid)
  local out = vim.fn.system(string.format("lsof -Fpn -w -iTCP -sTCP:LISTEN -p %d -a -P -n", pid))
  return tonumber(out:match(":(%d+)\n"))
end

local function find_opencode_port_in_window()
  local pane_pid = find_opencode_pane_pid()
  if not pane_pid then
    return nil
  end
  local opencode_pid = resolve_opencode_pid(pane_pid)
  if not opencode_pid then
    return nil
  end
  return get_port_for_pid(opencode_pid)
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

-- Connect to a specific port, bypassing cwd-based server selection.
local function connect_to_port(port)
  require("opencode.server")
    .new(port)
    :next(function(server)
      require("opencode.events").connect(server)
      vim.notify(
        "Connected to opencode server (port " .. server.port .. ", current port " .. port .. ")",
        vim.log.levels.INFO,
        { title = "opencode" }
      )
    end)
    :catch(function(err)
      vim.notify("Failed to connect to opencode server: " .. err, vim.log.levels.WARN, { title = "opencode" })
    end)
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

  local port = find_opencode_port_in_window()
  if not port then
    start_server()
    vim.defer_fn(function()
      local new_port = find_opencode_port_in_window()
      if new_port then
        connect_to_port(new_port)
      else
        connect()
      end
    end, 500)
    return
  end

  connect_to_port(port)
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

  local port = find_opencode_port_in_window()
  if not port then
    start_server()
    sleep(2000)
    port = find_opencode_port_in_window()
  end

  if port then
    connect_to_port(port)
  else
    connect()
  end

  local success = wait_for_connected_server(events, timeout)
  if not success then
    vim.notify("Timeout waiting for opencode server", vim.log.levels.WARN, { title = "opencode" })
  end
  return success
end

return M
