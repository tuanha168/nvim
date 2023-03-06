require("nvim-treesitter.configs").setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["as"] = "@scope",
      },
      include_surrounding_whitespace = true,
    },
  },
}
