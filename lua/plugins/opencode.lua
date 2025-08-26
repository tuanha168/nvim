return {
  {
    "sudo-tee/opencode.nvim",
    event = "VeryLazy",
    config = function() require("opencode").setup {} end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
      },
    },
  },

  -- {
  --   "NickvanDyke/opencode.nvim",
  --   dependencies = {
  --     -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal — otherwise optional
  --     { "folke/snacks.nvim", opts = { input = { enabled = true } } },
  --   },
  --   ---@type opencode.Opts
  --   opts = {
  --     -- Your configuration, if any — see lua/opencode/config.lua
  --   },
  --   keys = {
  --     -- Recommended keymaps
  --     { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode" },
  --     {
  --       "<leader>oa",
  --       function() require("opencode").ask "@cursor: " end,
  --       desc = "Ask opencode about this",
  --       mode = "n",
  --     },
  --     {
  --       "<leader>oa",
  --       function() require("opencode").ask "@selection: " end,
  --       desc = "Ask opencode about selection",
  --       mode = "v",
  --     },
  --     { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle embedded opencode" },
  --     { "<leader>on", function() require("opencode").command "session_new" end, desc = "New session" },
  --     { "<leader>oy", function() require("opencode").command "messages_copy" end, desc = "Copy last message" },
  --     {
  --       "<C-M-u>",
  --       function() require("opencode").command "messages_half_page_up" end,
  --       desc = "Scroll messages up",
  --       mode = "n",
  --     },
  --     {
  --       "<C-M-d>",
  --       function() require("opencode").command "messages_half_page_down" end,
  --       desc = "Scroll messages down",
  --       mode = "n",
  --     },
  --     {
  --       "<leader>op",
  --       function() require("opencode").select_prompt() end,
  --       desc = "Select prompt",
  --       mode = { "n", "v" },
  --     },
  --     -- Example: keymap for custom prompt
  --     {
  --       "<leader>oe",
  --       function() require("opencode").prompt "Explain @cursor and its context" end,
  --       desc = "Explain code near cursor",
  --     },
  --   },
  -- },
}
