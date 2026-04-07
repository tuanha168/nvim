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
      {
        "<C-a>",
        function()
          if require("config.opencode_ensure").ensure_server_sync() then
            require("opencode").ask("@this: ")
          end
        end,
        mode = { "n", "x" },
        desc = "Ask opencode…"
      },
      {
        "<C-p>",
        function()
          if require("config.opencode_ensure").ensure_server_sync() then
            require("opencode").select()
          end
        end,
        mode = { "n", "x" },
        desc = "Execute opencode action…"
      },
      { "<Leader>cc", function() require("config.opencode_ensure").ensure_server() end, mode = { "n", "t" }, desc = "Start opencode server" },
      {
        "<Leader>go",
        function()
          if require("config.opencode_ensure").ensure_server_sync() then
            return require("opencode").operator("@this ")
          end
          return ""
        end,
        mode = { "n", "x" },
        desc = "Add range to opencode",
        expr = true
      },
      {
        "<Leader>goo",
        function()
          if require("config.opencode_ensure").ensure_server_sync() then
            return require("opencode").operator("@this ") .. "_"
          end
          return ""
        end,
        mode = "n",
        desc = "Add line to opencode",
        expr = true
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      vim.o.autoread = true -- Required for `opts.events.reload`
    end,
  }
}
