---@type LazySpec
return {
  {
    "robitx/gp.nvim",
    cmd = {
      "GpContext",
    },
    config = function()
      require("gp").setup {
        default_command_agent = "copilot",
        default_chat_agent = "copilot",
        providers = {
          copilot = {
            disabled = false,
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
