vim.pack.add { "https://github.com/folke/sidekick.nvim" }

vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    require("sidekick").setup {
      nes = {
        enabled = true,
      },
    }

    require("which-key").add {
      {
        "<C-f>",
        function() require("sidekick").nes_jump_or_apply() end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<C-g>",
        function() require("sidekick.nes").update() end,
        expr = true,
        desc = "Sidekick Update Suggestions",
      },
      {
        "<C-p>",
        function()
          if require("config.opencode_ensure").ensure_server_sync() then require("sidekick.cli").prompt() end
        end,
        mode = { "n", "x" },
        desc = "Execute opencode action…",
      },
      {
        "<Leader>cv",
        function() require("config.opencode_ensure").ensure_server() end,
        mode = { "n", "v", "t" },
        desc = "Start opencode server",
      },
      {
        "<Leader>cc",
        function()
          if require("config.opencode_ensure").ensure_server_sync() then
            require("sidekick.cli").send({ msg = "{line}" })
          end
        end,
        mode = { "x" },
        desc = "Add range to opencode",
      },
      {
        "<Leader>cc",
        function()
          if require("config.opencode_ensure").ensure_server_sync() then
            require("sidekick.cli").send({ msg = "{line}" })
          end
        end,
        mode = "n",
        desc = "Add line to opencode",
      },
    }
  end,
  once = true,
})
