---@type LazySpec
return {
  {
    "carlos-algms/agentic.nvim",
    enabled = true,

    event = "VeryLazy",

    opts = {
      -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp"
      provider = "opencode-acp", -- setting the name here is all you need to get started
    },

    -- these are just suggested keymaps; customize as desired
    keys = {
      {
        "<Leader>cc",
        function() require("agentic").toggle() end,
        mode = { "n", "v", "i" },
        desc = "Toggle Agentic Chat",
      },
      {
        "<Leader>ca",
        function() require("agentic").add_selection_or_file_to_context() end,
        mode = { "n", "v" },
        desc = "Add file or selection to Agentic to Context",
      },
      {
        "<Leader>cn",
        function() require("agentic").new_session() end,
        mode = { "n", "v", "i" },
        desc = "New Agentic Session",
      },
      {
        "<Leader>cr", -- ai Restore
        function()
          require("agentic").restore_session()
        end,
        desc = "Agentic Restore session",
        silent = true,
        mode = { "n", "v", "i" },
      },
    },
  },
}
