local M = {}

local SPAWN_TIMEOUT_MS = 30000
local CONNECT_TIMEOUT_MS = 5000
local POLL_INTERVAL_MS = 500

local function start_server()
  local cwd = vim.fn.getcwd()
  local pane_id =
    vim.fn.system(string.format("tmux split-window -d -P -F '#{pane_id}' -h -l 35%% -c %q 'opencode --port'", cwd))
  pane_id = vim.trim(pane_id)
  if pane_id ~= "" then vim.fn.system(string.format("tmux set-option -t %s -p allow-passthrough off", pane_id)) end
end

local function find_opencode_pane_pid()
  local panes = vim.fn.system "tmux list-panes -F '#{pane_pid} #{pane_current_command}'"
  for line in panes:gmatch "[^\r\n]+" do
    local pid, cmd = line:match "^(%d+)%s+(.+)$"
    if cmd == "opencode" then return tonumber(pid) end
  end
  return nil
end

-- pane_pid may be the shell (user-spawned) or opencode itself (nvim-spawned).
-- Resolve to the actual opencode pid either way.
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

local function find_opencode_port_in_window()
  local pane_pid = find_opencode_pane_pid()
  if not pane_pid then return nil end
  local opencode_pid = resolve_opencode_pid(pane_pid)
  if not opencode_pid then return nil end
  return get_port_for_pid(opencode_pid)
end

local function is_connected()
  return require("sidekick.cli.state").is { tool = { name = "opencode" } }, { attached = true } ~= nil
end

local function wait_for_connected_server(timeout)
  return vim.wait(timeout, function() return is_connected() end, 100)
end

local function poll_for_port_in_window(timeout_ms, interval_ms, on_found, on_timeout)
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
      local port = find_opencode_port_in_window()
      if port then
        timer:stop()
        timer:close()
        on_found(port)
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

-- Connect to a specific port, bypassing cwd-based server selection.
local function connect_to_port(port)
  require("opencode.server")
    .new("http://localhost:" .. port)
    :next(function(server) return server:connect() end)
    :next(function(server)
      vim.notify("Connected to opencode server (port " .. port .. ")", vim.log.levels.INFO, { title = "opencode" })
      return server
    end)
    :catch(
      function(err)
        vim.notify(
          "Failed to connect to opencode server: " .. (err or "unknown error"),
          vim.log.levels.WARN,
          { title = "opencode" }
        )
      end
    )
end

local function start_default_split() require("opencode.server.discovery").get() end

function M.ensure_server()
  if is_connected() then return end

  if vim.env.TMUX == nil then
    start_default_split()
    return
  end

  local port = find_opencode_port_in_window()
  if not port then
    start_server()
    poll_for_port_in_window(
      SPAWN_TIMEOUT_MS,
      POLL_INTERVAL_MS,
      connect_to_port,
      function() vim.notify("Timeout waiting for opencode server to start", vim.log.levels.WARN, { title = "opencode" }) end
    )
    return
  end

  connect_to_port(port)
end

function M.ensure_server_sync()
  if is_connected() then return true end

  if vim.env.TMUX == nil then
    start_default_split()
    return true
  end

  local port = find_opencode_port_in_window()
  if not port then
    start_server()
    local elapsed = 0
    while not port and elapsed < SPAWN_TIMEOUT_MS do
      vim.loop.sleep(POLL_INTERVAL_MS)
      elapsed = elapsed + POLL_INTERVAL_MS
      port = find_opencode_port_in_window()
    end
  end

  if not port then
    vim.notify("Timeout waiting for opencode server to start", vim.log.levels.WARN, { title = "opencode" })
    return false
  end

  connect_to_port(port)

  local success = wait_for_connected_server(CONNECT_TIMEOUT_MS)
  if not success then vim.notify("Timeout waiting for opencode server", vim.log.levels.WARN, { title = "opencode" }) end
  return success
end

return M
