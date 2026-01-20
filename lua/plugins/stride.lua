---@type LazySpec
return {
  {
    "jim-at-jibba/nvim-stride",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter", -- optional, smart context
      "folke/snacks.nvim", -- optional, animated notifications
    },
    opts = {
      mode = "both"
    }
  },
}
