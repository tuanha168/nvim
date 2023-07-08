return {
  "b0o/SchemaStore.nvim",
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
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
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        opts = function(_, opts)
          if not opts.handlers then opts.handlers = {} end
          opts.handlers = require("lsp.setup_handlers")
          return opts
        end,
        config = function(_, opts)
          require("mason-lspconfig").setup(opts)
        end,
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      { "jay-babu/mason-null-ls.nvim" },
    },
    opts = {}
    -- opts = function() return { on_attach = require("astronvim.utils.lsp").on_attach } end,
  },
  {
    "MunifTanjim/prettier.nvim",
    keys = { "<leader>fm" },
    opts = {
      bin = "prettierd", -- or `'prettierd'` (v0.23.3+)
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
        "vue",
      },
    },
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
