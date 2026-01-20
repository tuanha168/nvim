return {
  {
    "folke/sidekick.nvim",
    event = { "InsertEnter" },
    opts = {
      -- add any options here
      nes = {
        enabled = false,
      },
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      -- {
      --   "<C-f>",
      --   function()
      --     -- if there is a next edit, jump to it, otherwise apply it if any
      --     if not require("sidekick").nes_jump_or_apply() then return "<C-f>" end
      --   end,
      --   expr = true,
      --   desc = "Goto/Apply Next Edit Suggestion",
      -- },
      {
        "<C-g>",
        function() require("sidekick.nes").update() end,
        expr = true,
        desc = "Sidekick Update Suggestions",
      },
      {
        "<C-h>",
        function() require("sidekick.cli").focus() end,
        mode = { "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<Leader>ca",
        function() require("sidekick.cli").toggle { focus = true } end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<Leader>cc",
        function() require("sidekick.cli").toggle { name = "opencode", focus = true } end,
        desc = "Sidekick Claude Toggle",
        mode = { "n", "v" },
      },
      {
        "<Leader>cp",
        function() require("sidekick.cli").prompt() end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
}
