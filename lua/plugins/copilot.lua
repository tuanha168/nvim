local NES = true

---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    -- enabled = not NES,
    event = { "InsertEnter" },
    keys = {
      { "<C-f>", mode = "i" },
      { "<C-j>", mode = "i" },
      { "<C-k>", mode = "i" },
    },
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

  {
    "copilotlsp-nvim/copilot-lsp",
    -- enabled = NES,
    -- dependencies = {
    --   {
    --     "saghen/blink.cmp",
    --     dependencies = { "fang2hou/blink-copilot" },
    --     opts = function(_, opts)
    --       table.insert(opts.sources.default, 1, "copilot")

    --       opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
    --         providers = {
    --           copilot = {
    --             name = "copilot",
    --             module = "blink-copilot",
    --             score_offset = 100,
    --             async = true,
    --           },
    --         },
    --       })
    --       return opts
    --     end,
    --   },
    -- },
    keys = {
      {
        "<C-f>",
        function()
          local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
            or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
        end,
        mode = { "n" },
      },
    },
    event = "VeryLazy",
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
