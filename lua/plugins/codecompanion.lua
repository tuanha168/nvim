return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4",
              },
            },
          })
        end,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
