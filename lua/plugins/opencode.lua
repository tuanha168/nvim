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
      { "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode…" },
      { "<C-p>", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Execute opencode action…" },
      { "<Leader>cc", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode" },
      { "<Leader>go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, desc = "Add range to opencode", expr = true },
      { "<Leader>goo", function() return require("opencode").operator("@this ") .. "_" end, mode = "n", desc = "Add line to opencode", expr = true },
      { "<C-S-u>", function() require("opencode").command("session.half.page.up") end, mode = "n", desc = "Scroll opencode up" },
      { "<C-S-d>", function() require("opencode").command("session.half.page.down") end, mode = "n", desc = "Scroll opencode down" },
    },
    config = function()
      -- local opencode_cmd = 'opencode --port'
      -- ---@type snacks.terminal.Opts
      -- local snacks_terminal_opts = {
      --   win = {
      --     position = 'right',
      --     enter = false,
      --     on_win = function(win)
      --       -- Set up keymaps and cleanup for an arbitrary terminal
      --       require('opencode.terminal').setup(win.win)
      --     end,
      --   },
      -- }
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- server = {
        --   start = function()
        --     require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
        --   end,
        --   stop = function()
        --     require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close()
        --   end,
        --   toggle = function()
        --     require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
        --   end,
        -- },
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- vim.api.nvim_create_autocmd("VimLeavePre", {
      --   once = true,
      --   callback = function()
      --     local term = require('snacks.terminal').get(opencode_cmd, { create = false })
      --     if term and term.buf and vim.api.nvim_buf_is_valid(term.buf) then
      --       local job_id = vim.b[term.buf].terminal_job_id
      --       if job_id then
      --         vim.fn.jobstop(job_id)
      --       end
      --     end
      --   end,
      -- })
    end,
  }
}
