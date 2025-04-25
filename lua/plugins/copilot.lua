---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    keys = {
      { "<C-f>", mode = "i" },
    },
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<C-f>",
          next = "<C-j>",
          prev = "<C-k>",
        },
      },
    },
  },

  -- {
  --   "copilotlsp-nvim/copilot-lsp",
  --   init = function()
  --     vim.g.copilot_nes_debounce = 10
  --     vim.lsp.enable "copilot"
  --     vim.keymap.set("n", "<C-f>", function() require("copilot-lsp.nes").apply_pending_nes() end)
  --   end,
  -- },
}
