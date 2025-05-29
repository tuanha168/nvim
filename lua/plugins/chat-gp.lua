---@type LazySpec
return {
  {
    "robitx/gp.nvim",
    opts = {
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
      hooks = {
        RewriteToDiff = function(gp, params)
          local template = "I have the following from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Rewrite it based on these instructions: {{command}}\n\n"
            .. "Respond with the following:\n\n"
            .. "  - a code block containing the rewritten code\n\n"
            .. "  - a brief explanation of the changes that were made along with the reasons for doing so\n\n"
            .. '  - a "diff" code block that shows the code changes in a diff format.\n\n'
          local agent = gp.get_chat_agent()
          local input_prompt = "🤖 " .. agent.name .. " ~"
          gp.Prompt(params, gp.Target.popup, agent, template, input_prompt)
        end,
      },
    },
    keys = {
      -- toggle
      { "<C-g>t", "<cmd>GpChatToggle<cr>", mode = { "n", "i" }, desc = "GPT prompt Toggle Chat" },
      { "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", mode = "v", desc = "GPT prompt Visual Toggle Chat" },

      -- finder
      { "<C-g><C-f>", "<cmd>GpChatFinder<cr>", mode = { "n", "i" }, desc = "GPT prompt Chat Finder" },

      -- paste
      { "<C-g>p", ":<C-u>'<,'>GpChatPaste vsplit<cr>", mode = "v", desc = "GPT prompt Visual Chat Paste" },

      -- New Chat with current file as context
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
        "<C-g><C-x>",
        ":<C-u>'<,'>GpRewriteToDiff<cr>",
        mode = { "v" },
        desc = "GPT prompt New Chat split in visual mode",
      },
      {
        "<C-g><C-v>",
        ":<C-u>'<,'>GpChatNew vsplit<cr>",
        mode = { "v" },
        desc = "GPT prompt New Chat vsplit in visual mode",
      },

      -- New Chat
      { "<C-g>S", "<cmd>GpChatNew split<cr>", mode = { "n", "i" }, desc = "GPT prompt New Chat split without context" },
      {
        "<C-g>V",
        "<cmd>GpChatNew vsplit<cr>",
        mode = { "n", "i" },
        desc = "GPT prompt New Chat vsplit without context",
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
  },
}
