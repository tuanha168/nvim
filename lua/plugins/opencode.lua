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
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      vim.o.autoread = true -- Required for `opts.events.reload`
    end,
  }
}
