---@type LazySpec
return {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   opts = {
  --     panel = {
  --       enabled = false,
  --     },
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       keymap = {
  --         accept = "<C-f>",
  --         next = "<C-j>",
  --         prev = "<C-k>",
  --       },
  --     },
  --   },
  -- },
  "copilotlsp-nvim/copilot-lsp",
  init = function()
    vim.g.copilot_nes_debounce = 500
    vim.lsp.enable "copilot"
    vim.keymap.set("n", "<C-f>", function() require("copilot-lsp.nes").apply_pending_nes() end)

    vim.keymap.set("n", "<C-j>", function() require("copilot-lsp.suggestions").next() end)
    vim.keymap.set("n", "<C-k>", function() require("copilot-lsp.suggestions").prev() end)
  end,
}
