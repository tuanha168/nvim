return {
  "b0o/SchemaStore.nvim",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        opts = function()
          local global_settings
          local _, depth = vim.fn.stdpath("config"):gsub("/", "")
          return { global_settings = global_settings and string.rep("../", depth):sub(1, -2) .. global_settings }
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },
    },
    event = "BufRead",
    -- config = require "plugins.configs.lspconfig",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      { "jay-babu/mason-null-ls.nvim" },
    },
    event = "BufRead",
    -- opts = function() return { on_attach = require("astronvim.utils.lsp").on_attach } end,
  },
  -- {
  --   "stevearc/aerial.nvim",
  --   event = "User AstroFile",
  --   opts = {
  --     attach_mode = "global",
  --     backends = { "lsp", "treesitter", "markdown", "man" },
  --     layout = { min_width = 28 },
  --     show_guides = true,
  --     filter_kind = false,
  --     guides = {
  --       mid_item = "├ ",
  --       last_item = "└ ",
  --       nested_top = "│ ",
  --       whitespace = "  ",
  --     },
  --     keymaps = {
  --       ["[y"] = "actions.prev",
  --       ["]y"] = "actions.next",
  --       ["[Y"] = "actions.prev_up",
  --       ["]Y"] = "actions.next_up",
  --       ["{"] = false,
  --       ["}"] = false,
  --       ["[["] = false,
  --       ["]]"] = false,
  --     },
  --   },
  -- },
}
