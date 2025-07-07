return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {

        "olimorris/codecompanion.nvim",
        opts = function(_, opts)
          opts.extensions = opts.extensions or {}
          opts.extensions.mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true, -- Show mcp tool results in chat
              make_vars = true, -- Convert resources to #variables
              make_slash_commands = true, -- Add prompts as /slash commands
            },
          }
          return opts
        end,
      },
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    opts = {},
  },
}
