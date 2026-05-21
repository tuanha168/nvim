vim.pack.add { "https://github.com/folke/sidekick.nvim" }

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("sidekick").setup {
      nes = {
        enabled = false,
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
    }
  end,
  once = true,
})
