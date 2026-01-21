---@type LazySpec
return {
  {
    "jim-at-jibba/nvim-stride",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter", -- optional, smart context
      "folke/snacks.nvim", -- optional, animated notifications
    },
    opts = {
      mode = "both",
      accept_keymap = "<C-f>", -- Use Ctrl+Y instead of Tab
    },
  },
}
