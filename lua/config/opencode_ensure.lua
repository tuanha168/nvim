local M = {}

local function start_server()
  local cwd = vim.fn.getcwd()
  vim.fn.system(string.format("tmux split-window -d -h -l 35%% -c %q 'opencode --port'", cwd))
end

local function find_server_in_tmux_window()
  local panes = vim.fn.system("tmux list-panes -F '#{pane_pid} #{pane_current_command}'")
  for line in panes:gmatch("[^\r\n]+") do
    local pid = line:match("^(%d+)%s+")
    if pid then
      local cmdline = vim.fn.system(string.format("ps -p %s -o args=", pid)):gsub("%s+$", "")
      if cmdline:match("opencode.*%-%-port") then
        return tonumber(pid)
      end
    end
  end
  return nil
end

local function connect()
  require("opencode.server").get(false):next(function(server)
    vim.notify("Connected to opencode server (port " .. server.port .. ")", vim.log.levels.INFO, { title = "opencode" })
  end):catch(function(err)
    vim.notify("Failed to connect to opencode server: " .. err, vim.log.levels.WARN, { title = "opencode" })
  end)
end

function M.ensure_server()
  local events = require("opencode.events")
  if events.connected_server then
    return
  end

  if vim.env.TMUX == nil then
    vim.notify("Not running inside tmux", vim.log.levels.ERROR, { title = "opencode" })
    return
  end

  local tmux_pid = find_server_in_tmux_window()
  if tmux_pid then
    connect()
  else
    start_server()
    vim.defer_fn(connect, 2000)
  end
end

function M.ensure_server_sync(timeout)
  timeout = timeout or 5000
  local events = require("opencode.events")
  if events.connected_server then
    return true
  end

  if vim.env.TMUX == nil then
    vim.notify("Not running inside tmux", vim.log.levels.ERROR, { title = "opencode" })
    return false
  end

  local tmux_pid = find_server_in_tmux_window()
  if tmux_pid then
    connect()
  else
    start_server()
    vim.wait(2000, function() return false end)
    connect()
  end

  local success = vim.wait(timeout, function() return events.connected_server end, 100)
  if not success then
    vim.notify("Timeout waiting for opencode server", vim.log.levels.WARN, { title = "opencode" })
  end
  return success
end

return M
