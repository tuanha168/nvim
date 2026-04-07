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

          local cwd = vim.fn.getcwd()
          vim.fn.system(string.format("tmux split-window -h -l 35%% -c %q 'opencode --port'", cwd))

          vim.defer_fn(function()
            require("opencode.server").get(false)
          end, 2000)
        end,
        mode = { "n", "t" },
        desc = "Start opencode server",
      },
      { "<C-a>", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, desc = "Add range to opencode", expr = true },
      { "<C-a>", function() return require("opencode").operator("@this ") .. "_" end, mode = "n", desc = "Add line to opencode", expr = true },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      vim.o.autoread = true -- Required for `opts.events.reload`
    end,
  }
}
