---@type LazySpec
return {
  {
    "dlants/magenta.nvim",
    enabled = true,
    lazy = false, -- you could also bind to <leader>mt
    build = "npm install --frozen-lockfile",
    opts = {
      profiles = {
        {
          name = "copilot-claude",
          provider = "copilot",
          model = "claude-sonnet-4",
          fastModel = "gpt-4.1",
        },
        {
          name = "copilot-4.1",
          provider = "copilot",
          model = "gpt-4.1",
          fastModel = "gpt-4.1",
        },
      },
      picker = "snacks",
      sidebarPosition = "right",
      mcpServers = {
        mcphub = {
          url = "http://localhost:37373/mcp",
        },
      },
      commandAllowlist = {
        "^ls( [^;&|()<>]*)?$",
        "^pwd$",
        "^echo( [^;&|()<>]*)?$",
        "^ls [^;&()<>]* | grep [^;&|()<>]*$",
        "^echo [^;&|()<>]* > [a-zA-Z0-9_\\-.]+$",
        "^grep( -[A-Za-z]*)? [^;&|()<>]*$",
      },
    },
    dependencies = {
      "ravitemer/mcphub.nvim",
    },
  },
}
