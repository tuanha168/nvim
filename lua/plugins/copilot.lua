---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    event = { "BufEnter" },
    opts = {
      panel = {
        enabled = false,
      },
      copilot_model = "claude-sonnet-4",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-f>",
          next = "<C-j>",
          prev = "<C-k>",
        },
      },
      nes = {
        enabled = true,
        keymap = {
          accept_and_goto = "<C-g>",
          accept = false,
          dismiss = "<Esc>",
        },
      },
    },
  },

  -- {
  --   "Xuyuanp/nes.nvim",
  --   event = "VeryLazy",
  --   keys = {
  --     {
  --       "<C-g>",
  --       function() require("nes").get_suggestion() end,
  --       mode = "n",
  --       desc = "[Nes] get suggestion",
  --     },
  --     {
  --       "<C-f>",
  --       function() require("nes").apply_suggestion(0, { jump = true, trigger = true }) end,
  --       mode = "n",
  --       desc = "[Nes] apply suggestion",
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "zbirenbaum/copilot.lua",
  --   },
  --   opts = {},
  -- },

  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   cmd = {
  --     "CopilotChat",
  --     "CopilotChatToggle",
  --     "CopilotChatPrompts",
  --     "CopilotChatModels",
  --     "CopilotChatAgents",
  --   },
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" },                   -- or zbirenbaum/copilot.lua
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --   },
  --   -- build = "make tiktoken", -- Only on MacOS or Linux
  --   opts = {
  --     model = "claude-sonnet-4",
  --     mappings = {
  --       show_diff = {
  --         full_diff = true,
  --       },
  --       reset = {
  --         normal = "",
  --         insert = "",
  --       },
  --     },
  --     -- See Configuration section for options
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
}
