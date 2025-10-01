return {
  {
    "folke/sidekick.nvim",
    dependencies = {
      "rebelot/heirline.nvim",
    },
    opts = {
      -- add any options here
      nes = {
        enabled = true,
      },
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<Tab>",
        function()
          Print "sidekick"
          -- if there is a next edit, jump to it, otherwise apply it if any
          if require("sidekick").nes_jump_or_apply() then
            Print "Jumped to next edit suggestion"
            return
          end
          Print "heirline"
          local ok, buffer = pcall(require, "heirline-components.buffer")
          Print("ok " .. string(ok) .. " ")
          if not ok then return "<Tab>" end

          buffer.nav(1)
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<C-.>",
        function() require("sidekick.cli").focus() end,
        mode = { "n", "x", "i", "t" },
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
        function() require("sidekick.cli").select_prompt() end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
}
