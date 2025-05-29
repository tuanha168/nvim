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
          },
        },
      }
    end,
  },
}
