---@type LazySpec
return {
  {
    "robitx/gp.nvim",
    keys = {
      -- Chat commands
      { "<C-g>t", "<cmd>GpChatToggle<cr>", mode = { "n", "i" }, desc = "GPT prompt Toggle Chat" },
      { "<C-g>f", "<cmd>GpChatFinder<cr>", mode = { "n", "i" }, desc = "GPT prompt Chat Finder" },
      { "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", mode = "v", desc = "GPT prompt Visual Chat New" },
      { "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", mode = "v", desc = "GPT prompt Visual Chat Paste" },
      { "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", mode = "v", desc = "GPT prompt Visual Toggle Chat" },
      { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat split" },
      { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat vsplit" },
      { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat tabnew" },

      -- New Chat with current file as context
      { "<C-g>c", "<cmd>%GpChatNew<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat with full file" },
      {
        "<C-g><C-x>",
        "<cmd>%GpChatNew split<cr>",
        mode = { "n", "i" },
        desc = "GPT prompt New Chat with full file split",
      },
      {
        "<C-g><C-v>",
        "<cmd>%GpChatNew vsplit<cr>",
        mode = { "n", "i" },
        desc = "GPT prompt New Chat with full file vsplit",
      },
      {
        "<C-g><C-t>",
        "<cmd>%GpChatNew tabnew<cr>",
        mode = { "n", "i" },
        desc = "GPT prompt New Chat with full file tabnew",
      },
      { "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", mode = { "v" }, desc = "GPT prompt New Chat without context" },
      {
        "<C-g><C-x>",
        ":<C-u>'<,'>GpChatNew split<cr>",
        mode = { "v" },
        desc = "GPT prompt New Chat split without context",
      },
      {
        "<C-g><C-v>",
        ":<C-u>'<,'>GpChatNew vsplit<cr>",
        mode = { "v" },
        desc = "GPT prompt New Chat vsplit without context",
      },
      {
        "<C-g><C-t>",
        ":<C-u>'<,'>GpChatNew tabnew<cr>",
        mode = { "v" },
        desc = "GPT prompt New Chat tabnew without context",
      },

      -- New Chat
      { "<C-g>C", "<cmd>GpChatNew<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat without context" },
      { "<C-g>S", "<cmd>GpChatNew split<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat split without context" },
      {
        "<C-g>V",
        "<cmd>GpChatNew vsplit<cr>",
        mode = { "n", "i" },
        desc = "GPT prompt New Chat vsplit without context",
      },
      {
        "<C-g>T",
        "<cmd>GpChatNew tabnew<cr>",
        mode = { "n", "i" },
        desc = "GPT prompt New Chat tabnew without context",
      },

      -- Prompt commands
      { "<C-g>r", "<cmd>GpRewrite<cr>", mode = { "n", "i" }, desc = "GPT prompt Inline Rewrite" },
      { "<C-g>a", "<cmd>GpAppend<cr>", mode = { "n", "i" }, desc = "GPT prompt Append (after)" },
      { "<C-g>b", "<cmd>GpPrepend<cr>", mode = { "n", "i" }, desc = "GPT prompt Prepend (before)" },
      { "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", mode = "v", desc = "GPT prompt Visual Rewrite" },
      { "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", mode = "v", desc = "GPT prompt Visual Append (after)" },
      { "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", mode = "v", desc = "GPT prompt Visual Prepend (before)" },
      { "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", mode = "v", desc = " GPT prompt Implement selection" },

      -- Stop and agent selection commands
      { "<C-g>s", "<cmd>GpStop<cr>", mode = { "n", "i", "v", "x" }, desc = "Stop" },
      { "<C-g>n", "<cmd>GpNextAgent<cr>", mode = { "n", "i", "v", "x" }, desc = "Next Agent" },
    },
    config = function()
      require("gp").setup {
        default_command_agent = "copilot",
        default_chat_agent = "copilot",
        chat_confirm_delete = false,
        chat_free_cursor = true,
        chat_template = require("gp.defaults").short_chat_template,
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
