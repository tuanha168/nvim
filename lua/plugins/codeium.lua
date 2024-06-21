---@type LazySpec
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
    branch = "main",
    keys = {
      { mode = "n", "<C-g>", function() return vim.fn["codeium#Chat"]() end, expr = true, silent = true },
      { mode = "i", "<C-f>", function() return vim.fn["codeium#Accept"]() end, expr = true, silent = true },
      {
        mode = "i",
        "<C-J>",
        function() return vim.fn["codeium#CycleOrComplete"]() end,
        expr = true,
        silent = true,
      },
      {
        mode = "i",
        "<C-K>",
        function() return vim.fn["codeium#CycleCompletions"](-1) end,
        expr = true,
        silent = true,
      },
    },
    config = function() vim.g.codeium_disable_bindings = 1 end,
  },
}
