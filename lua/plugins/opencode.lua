return {
  -- {
  --   "sudo-tee/opencode.nvim",
  --   lazy = false,
  --   opts = {
  --     keymap = {
  --       global = {
  --         toggle = "<leader>oa", -- Open opencode. Close if opened
  --         open_input = "<leader>oi", -- Opens and focuses on input window on insert mode
  --         open_input_new_session = "<leader>oI", -- Opens and focuses on input window on insert mode. Creates a new session
  --         open_output = "<leader>oo", -- Opens and focuses on output window
  --         toggle_focus = "<leader>ot", -- Toggle focus between opencode and last window
  --         close = "<leader>oq", -- Close UI windows
  --         select_session = "<leader>os", -- Select and load a opencode session
  --         configure_provider = "<leader>op", -- Quick provider and model switch from predefined list
  --         diff_open = "<leader>od", -- Opens a diff tab of a modified file since the last opencode prompt
  --         diff_next = "<leader>o]", -- Navigate to next file diff
  --         diff_prev = "<leader>o[", -- Navigate to previous file diff
  --         diff_close = "<leader>oc", -- Close diff view tab and return to normal editing
  --         diff_revert_all_last_prompt = "<leader>ora", -- Revert all file changes since the last opencode prompt
  --         diff_revert_this_last_prompt = "<leader>ort", -- Revert current file changes since the last opencode prompt
  --         diff_revert_all = "<leader>orA", -- Revert all file changes since the last opencode session
  --         diff_revert_this = "<leader>orT", -- Revert current file changes since the last opencode session
  --         swap_position = "<leader>ox", -- Swap Opencode pane left/right
  --       },
  --       window = {
  --         submit = "<cr>", -- Submit prompt (normal mode)
  --         submit_insert = "<C-s>", -- Submit prompt (insert mode)
  --         close = "<esc>", -- Close UI windows
  --         stop = "<C-c>", -- Stop opencode while it is running
  --         next_message = "]]", -- Navigate to next message in the conversation
  --         prev_message = "[[", -- Navigate to previous message in the conversation
  --         mention_file = "@", -- Pick a file and add to context. See File Mentions section
  --         slash_command = "/", -- Pick a command to run in the input window
  --         toggle_pane = "<tab>", -- Toggle between input and output panes
  --         prev_prompt_history = "<up>", -- Navigate to previous prompt in history
  --         next_prompt_history = "<down>", -- Navigate to next prompt in history
  --         switch_mode = "<M-m>", -- Switch between modes (build/plan)
  --         focus_input = "<C-i>", -- Focus on input window and enter insert mode at the end of the input from the output window
  --         debug_messages = "<leader>oD", -- Open raw message in new buffer for debugging
  --         debug_output = "<leader>oO", -- Open raw output in new buffer for debugging
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     {
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         anti_conceal = { enabled = false },
  --         file_types = { "markdown", "opencode_output" },
  --       },
  --       ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
  --     },
  --   },
  -- },

  {
    "nickjvandyke/opencode.nvim",
    dependencies = {
      -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal — otherwise optional
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    ---@type opencode.Opts
    opts = {
      -- Your configuration, if any — see lua/opencode/config.lua
    },
    keys = {
      -- Recommended keymaps
      { "<leader>oA", function() require("opencode").ask() end,                   desc = "Ask opencode" },
      {
        "<leader>oa",
        function() require("opencode").ask "@cursor: " end,
        desc = "Ask opencode about this",
        mode = "n",
      },
      {
        "<leader>oa",
        function() require("opencode").ask "@selection: " end,
        desc = "Ask opencode about selection",
        mode = "v",
      },
      { "<leader>ot", function() require("opencode").toggle() end,                desc = "Toggle embedded opencode" },
      { "<leader>on", function() require("opencode").command "session_new" end,   desc = "New session" },
      { "<leader>oy", function() require("opencode").command "messages_copy" end, desc = "Copy last message" },
      {
        "<C-M-u>",
        function() require("opencode").command "messages_half_page_up" end,
        desc = "Scroll messages up",
        mode = "n",
      },
      {
        "<C-M-d>",
        function() require("opencode").command "messages_half_page_down" end,
        desc = "Scroll messages down",
        mode = "n",
      },
      {
        "<leader>op",
        function() require("opencode").select() end,
        desc = "Select prompt",
        mode = { "n", "v" },
      },
      -- Example: keymap for custom prompt
      {
        "<leader>oe",
        function() require("opencode").prompt "Explain @cursor and its context" end,
        desc = "Explain code near cursor",
      },
    },
  },
}
