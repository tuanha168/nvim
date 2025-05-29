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
