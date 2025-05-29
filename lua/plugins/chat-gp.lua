---@type LazySpec
return {
  {
    "robitx/gp.nvim",
    cmd = {
      "GpChatToggle",
    },
    config = function()
      require("gp").setup {
        providers = {
          copilot = {
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = {
              "bash",
              "-c",
              "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
        },
      }
    end,
  },
}
