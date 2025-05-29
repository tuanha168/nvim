---@type LazySpec
return {
  {
    "robitx/gp.nvim",
    cmd = {
      "GpChatToggle",
    },
    keys = {
      -- Chat commands
      { "<C-g>c", "<cmd>GpChatNew<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat" },
      { "<C-g>t", "<cmd>GpChatToggle<cr>", mode = { "n", "i" }, desc = "GPT prompt Toggle Chat" },
      { "<C-g>f", "<cmd>GpChatFinder<cr>", mode = { "n", "i" }, desc = "GPT prompt Chat Finder" },
      { "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", mode = "v", desc = "GPT prompt Visual Chat New" },
      { "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", mode = "v", desc = "GPT prompt Visual Chat Paste" },
      { "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", mode = "v", desc = "GPT prompt Visual Toggle Chat" },
      { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat split" },
      { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat vsplit" },
      { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat tabnew" },
      { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", mode = "v", desc = "GPT prompt Visual Chat New split" },
      { "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", mode = "v", desc = "GPT prompt Visual Chat New vsplit" },
      { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", mode = "v", desc = "GPT prompt Visual Chat New tabnew" },

      -- Prompt commands
      { "<C-g>r", "<cmd>GpRewrite<cr>", mode = { "n", "i" }, desc = "GPT prompt Inline Rewrite" },
      { "<C-g>a", "<cmd>GpAppend<cr>", mode = { "n", "i" }, desc = "GPT prompt Append (after)" },
      { "<C-g>b", "<cmd>GpPrepend<cr>", mode = { "n", "i" }, desc = "GPT prompt Prepend (before)" },
      { "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", mode = "v", desc = "GPT prompt Visual Rewrite" },
      { "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", mode = "v", desc = "GPT prompt Visual Append (after)" },
      { "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", mode = "v", desc = "GPT prompt Visual Prepend (before)" },
      { "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", mode = "v", desc = " GPT prompt Implement selection" },

      -- Miscellaneous commands
      { "<C-g>gp", "<cmd>GpPopup<cr>", mode = { "n", "i" }, desc = "Popup" },
      { "<C-g>ge", "<cmd>GpEnew<cr>", mode = { "n", "i" }, desc = "GpEnew" },
      { "<C-g>gn", "<cmd>GpNew<cr>", mode = { "n", "i" }, desc = "GpNew" },
      { "<C-g>gv", "<cmd>GpVnew<cr>", mode = { "n", "i" }, desc = "GpVnew" },
      { "<C-g>gt", "<cmd>GpTabnew<cr>", mode = { "n", "i" }, desc = "GpTabnew" },
      { "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", mode = "v", desc = "Visual Popup" },
      { "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", mode = "v", desc = "Visual GpEnew" },
      { "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", mode = "v", desc = "Visual GpNew" },
      { "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", mode = "v", desc = "Visual GpVnew" },
      { "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", mode = "v", desc = "Visual GpTabnew" },

      -- Context commands
      { "<C-g>x", "<cmd>GpContext<cr>", mode = { "n", "i" }, desc = "Toggle Context" },
      { "<C-g>x", ":<C-u>'<,'>GpContext<cr>", mode = "v", desc = "Visual Toggle Context" },

      -- Stop and agent selection commands
      { "<C-g>s", "<cmd>GpStop<cr>", mode = { "n", "i", "v", "x" }, desc = "Stop" },
      { "<C-g>n", "<cmd>GpNextAgent<cr>", mode = { "n", "i", "v", "x" }, desc = "Next Agent" },
    },
    config = function()
      require("gp").setup {
        default_command_agent = "copilot",
        default_chat_agent = "copilot",
        providers = {
          copilot = {
            secret = {
              "bash",
              "-c",
              "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
        },
      }
    end,
  },
}
