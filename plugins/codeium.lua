return {
  -- {
  --   "jcdickinson/codeium.nvim",
  --   enabled = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   event = "InsertEnter",
  --   opts = {},
  -- },
  {
    "Exafunction/codeium.vim",
    -- enabled = false,
    event = "InsertEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set("i", "<C-f>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-j>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-k>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
    end,
  },
}
