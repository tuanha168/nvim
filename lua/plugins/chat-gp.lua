---@type LazySpec
return {
  {
    "robitx/gp.nvim",
    cmd = {
      "GpRewriteToDiff",
      "GpCodeReview",
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
          googleai = {
            disable = false,
          },
        },
        agents = {
          {
            provider = "googleai",
            name = "ChatGemini",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gemini-2.0-flash", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
        },
        hooks = {
          RewriteToDiff = function(gp, params)
            local template = "I have the following from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Rewrite it based on these instructions: {{command}}\n\n"
              .. "Response with the following:\n\n"
              .. "  - a code block containing the rewritten code\n\n"
              .. "  - a brief explanation of the changes that were made along with the reasons for doing so\n\n"
              .. '  - a "diff" code block that shows the code changes in a diff format.\n\n'
            local agent = gp.get_chat_agent()
            local input_prompt = "🤖 " .. agent.name .. " ~"
            gp.Prompt(params, gp.Target.vnew "markdown", agent, template, input_prompt)
          end,

          CodeReview = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please analyze for code smells and suggest improvements.\n\n"
              .. 'Then show me a "diff" code block that shows all the code changes in a diff format.\n\n'

            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.vnew "markdown", agent, template)
          end,
        },
      }
    end,
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
        "<C-g><C-d>",
        "<cmd>%GpRewriteToDiff<cr>",
        mode = { "n", "i" },
        desc = "GPT prompt New Chat with full file vsplit",
      },

      {
        "<C-g><C-x>",
        ":<C-u>'<,'>GpChatNew split<cr>",
        mode = { "v" },
        desc = "GPT prompt New Chat split in visual mode",
      },
      {
        "<C-g><C-v>",
        ":<C-u>'<,'>GpChatNew vsplit<cr>",
        mode = { "v" },
        desc = "GPT prompt New Chat vsplit in visual mode",
      },
      {
        "<C-g><C-d>",
        ":<C-u>'<,'>GpRewriteToDiff<cr>",
        mode = { "v" },
        desc = "GPT Rewrite to Diff in visual mode",
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
