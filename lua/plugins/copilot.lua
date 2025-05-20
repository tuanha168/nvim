---@type LazySpec
return {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = { "InsertEnter" },
  --   keys = {
  --     { "<C-f>", mode = "i" },
  --     { "<C-j>", mode = "i" },
  --     { "<C-k>", mode = "i" },
  --   },
  --   opts = {
  --     panel = {
  --       enabled = false,
  --     },
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       keymap = {
  --         accept = "<C-f>",
  --         next = "<C-j>",
  --         prev = "<C-k>",
  --       },
  --     },
  --   },
  -- },

  {
    "copilotlsp-nvim/copilot-lsp",
    event = { "InsertEnter" },
    init = function()
      vim.g.copilot_nes_debounce = 10
      vim.lsp.enable "copilot_ls"
      vim.keymap.set("n", "<C-f>", function() require("copilot-lsp.nes").apply_pending_nes() end)
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
      "CopilotChatPrompts",
      "CopilotChatModels",
      "CopilotChatAgents",
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
