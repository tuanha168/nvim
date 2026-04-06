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
    config = function()
      local opencode_cmd = 'opencode --port'
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = 'right',
          enter = false,
          on_win = function(win)
            -- Set up keymaps and cleanup for an arbitrary terminal
            require('opencode.terminal').setup(win.win)
          end,
        },
      }
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
          end,
          stop = function()
            require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close()
          end,
          toggle = function()
            require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
        { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
        { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<Leader>cc", function() require("opencode").toggle() end,
        { desc = "Toggle opencode" })
      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
        { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
        { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
        { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
        { desc = "Scroll opencode down" })
    end,
  }
}
