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
  --     copilot_model = "claude-sonnet-4",
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
    keys = {
      {
        "<C-f>",
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          local state = vim.b[bufnr].nes_state
          if state then
            -- Try to jump to the start of the suggestion edit.
            -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
            local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                or (
                  require("copilot-lsp.nes").apply_pending_nes()
                  and require("copilot-lsp.nes").walk_cursor_end_edit()
                )
          end
        end,
        desc = "Accept Copilot NES suggestion",
        expr = true,
        mode = { "n" },
      },
    },
    event = "BufEnter",
    opts = {
      nes = {
        move_count_threshold = 3, -- Clear after 3 cursor movements
      },
    },
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable "copilot_ls"
    end,
  },

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
