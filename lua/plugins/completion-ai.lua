---@type LazySpec
return {
  -- supermaven
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      -- keymaps = {
      --   accept_suggestion = "<C-F>",
      -- },
      -- ignore_filetypes = { cpp = true },
      -- color = {
      --   suggestion_color = "#ffffff",
      --   cterm = 244,
      -- },
      -- log_level = "info", -- set to "off" to disable logging completely
      -- disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = true, -- disables built in keymaps for more manual control
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)

      vim.keymap.set("i", "<C-F>", function()
        local suggestion = require "supermaven-nvim.completion_preview"
        if suggestion.has_suggestion() then suggestion.on_accept_suggestion() end
      end, { noremap = true, silent = true })

      vim.keymap.set("i", "<C-J>", function()
        local suggestion = require "supermaven-nvim.completion_preview"
        if suggestion.has_suggestion() then suggestion.on_accept_suggestion_word() end
      end, { noremap = true, silent = true })
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    event = "BufEnter",
    enabled = false,
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-f>",
          next = "<C-j>",
          prev = "<C-k>",
        },
      },
    },
  },

  -- codeium
  -- {
  --   "jcdickinson/codeium.nvim",
  --   enabled = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   event = "InsertEnter",
  --   opts = {},
  -- },
  {
    "Exafunction/codeium.vim",
    enabled = false,
    event = "BufEnter",
    branch = "main",
    keys = {
      { mode = "n", "<C-g>", function() return vim.fn["codeium#Chat"]() end, expr = true, silent = true },
      { mode = "i", "<C-f>", function() return vim.fn["codeium#Accept"]() end, expr = true, silent = true },
      {
        mode = "i",
        "<C-J>",
        function() return vim.fn["codeium#CycleOrComplete"]() end,
        expr = true,
        silent = true,
      },
      {
        mode = "i",
        "<C-K>",
        function() return vim.fn["codeium#CycleCompletions"](-1) end,
        expr = true,
        silent = true,
      },
    },
    config = function() vim.g.codeium_disable_bindings = 1 end,
  },

  -- tabnine
  -- {
  --   "tzachar/cmp-tabnine",
  --   event = "InsertEnter",
  --   build = "./install.sh",
  --   config = function() require("config.tabnine").setupCmp() end,
  -- },
  -- {
  --   "codota/tabnine-nvim",
  --   event = "InsertEnter",
  --   build = "./dl_binaries.sh",
  --   config = function() require("config.tabnine").setupClient() end,
  -- },

  -- olimorris
  -- {
  --   "olimorris/codecompanion.nvim",
  --   enabled = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   init = function()
  --     require("codecompanion").setup {
  --       strategies = {
  --         chat = "ollama",
  --         inline = "ollama",
  --       },

  --       adapters = {
  --         ollama = require("codecompanion.adapters").use("ollama", {
  --           schema = {
  --             model = {
  --               default = "deepseek-coder:6.7b",
  --             },
  --           },
  --         }),
  --       },
  --     }
  --   end,
  --   config = function()
  --     -- Expand `cc` into CodeCompanion in the command line
  --     vim.cmd [[cab cc CodeCompanion]]
  --   end,
  --   keys = {
  --     {
  --       "<leader>ic",
  --       "<cmd>CodeCompanionToggle<CR>",
  --       desc = "A[I] [C]hat",
  --       mode = { "n", "v" },
  --     },
  --     {
  --       "<leader>ia",
  --       "<cmd>CodeCompanion<CR>",
  --       desc = "A[I] [A]sk",
  --       mode = { "n", "v" },
  --     },
  --     {
  --       "<leader>il",
  --       "<cmd>CodeCompanionActions<CR>",
  --       desc = "A[I] [L]ist of actions",
  --       mode = { "n", "v" },
  --     },
  --   },
  -- },
}
