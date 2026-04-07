local M = {}

local function start_server()
  local cwd = vim.fn.getcwd()
  vim.fn.system(string.format("tmux split-window -h -l 35%% -c %q 'opencode --port'", cwd))
end

local function find_server_in_tmux_window()
  local panes = vim.fn.system("tmux list-panes -t '#{window_id}' -F '#{pane_pid} #{pane_current_command}'")
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

function M.ensure_server(callback)
  local events = require("opencode.events")
  if events.connected_server then
    if callback then
      callback()
    end
    return
  end

  if vim.env.TMUX == nil then
    vim.notify("Not running inside tmux", vim.log.levels.ERROR, { title = "opencode" })
    return
  end

  local function connect(opts)
    opts = opts or {}
    require("opencode.server").get(false):next(function(server)
      if opts.notify then
        vim.notify("Connected to opencode server (port " .. server.port .. ")", vim.log.levels.INFO, { title = "opencode" })
      end
      if callback then
        callback()
      end
    end):catch(function(err)
      vim.notify("Failed to connect to opencode server: " .. err, vim.log.levels.WARN, { title = "opencode" })
    end)
  end

  local tmux_pid = find_server_in_tmux_window()
  if tmux_pid then
    connect({ notify = true })
  else
    require("opencode.server").get_all():next(function()
      connect()
    end):catch(function()
      start_server()
      vim.defer_fn(connect, 2000)
    end)
  end
end

return M
