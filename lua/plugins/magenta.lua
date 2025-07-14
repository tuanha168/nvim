---@type LazySpec
return {
  {
    "dlants/magenta.nvim",
    keys = {
      { "<leader>mt", desc = "Magenta: Toggle" },
    },
    build = "npm install --frozen-lockfile",
    opts = {
      profiles = {
        {
          name = "copilot-claude",
          provider = "copilot",
          model = "claude-sonnet-4",
          fastModel = "gpt-4.1",
        },
      },
      picker = "snacks",
      sidebarPosition = "right",
    },
  },
}
