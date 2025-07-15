---@type LazySpec
return {
  {
    "dlants/magenta.nvim",
    enabled = true,
    -- keys = {
    --   { "<leader>mt", desc = "Magenta: Toggle" },
    -- },
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
      },
      picker = "snacks",
      sidebarPosition = "right",
    },
  },
}
