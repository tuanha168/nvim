---@type LazySpec
return {
  {
    "dlants/magenta.nvim",
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
    },
  },
}
