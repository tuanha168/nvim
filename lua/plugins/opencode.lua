return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = {  -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      { "<C-p>", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Execute opencode action…" },
      {
        "<Leader>cc",
        function()
          local events = require("opencode.events")
          if events.connected_server then
            return
          end

          if vim.env.TMUX == nil then
            vim.notify("Not running inside tmux", vim.log.levels.ERROR, { title = "opencode" })
            return
          end

          local function start_server()
            local cwd = vim.fn.getcwd()
            vim.fn.system(string.format("tmux split-window -h -l 35%% -c %q 'opencode --port'", cwd))
          end

          local function connect_to_server(opts)
            opts = opts or {}
            require("opencode.server").get(false):next(function(server)
              if opts.notify then
                vim.notify("Connected to opencode server (port " .. server.port .. ")", vim.log.levels.INFO, { title = "opencode" })
              end
            end):catch(function(err)
              vim.notify("Failed to connect to opencode server: " .. err, vim.log.levels.WARN, { title = "opencode" })
            end)
          end

          local panes = vim.fn.system("tmux list-panes -t '#{window_id}' -F '#{pane_pid} #{pane_current_command}'")
          local has_opencode = false

          for line in panes:gmatch("[^\r\n]+") do
            local pid, cmd = line:match("^(%d+)%s+(.+)$")
            if pid and cmd == "opencode" then
              local cmdline = vim.fn.system(string.format("ps -p %s -o args=", pid)):gsub("%s+$", "")
              if cmdline:match("opencode.*%-%-port") then
                has_opencode = true
                break
              end
            end
          end

          if has_opencode then
            connect_to_server({ notify = true })
          else
            require("opencode.server").get_all():next(function()
              connect_to_server()
            end):catch(function()
              start_server()
              vim.defer_fn(connect_to_server, 2000)
            end)
          end
        end,
        mode = { "n", "t" },
        desc = "Start opencode server",
      },
      { "<C-a>", function() return require("config.opencode_ensure").ensure_server(function() require("opencode").operator("@this ") end) end, mode = { "n", "x" }, desc = "Add range to opencode", expr = true },
      { "<C-a>", function() return require("config.opencode_ensure").ensure_server(function() return require("opencode").operator("@this ") .. "_" end) end, mode = "n", desc = "Add line to opencode", expr = true },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      vim.o.autoread = true -- Required for `opts.events.reload`
    end,
  }
}
