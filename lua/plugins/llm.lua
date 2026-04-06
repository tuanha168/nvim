---@type LazySpec
return {
  {
    'meeehdi-dev/bropilot.nvim',
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      provider = "ollama",
      auto_suggest = false,
      excluded_filetypes = {},
      model = "qwen2.5-coder:14b",
      keymap = {
        accept_word = "<C-f>",
        accept_line = "<C-g>",
        accept_block = "<Tab>",
        suggest = "<C-Down>",
      },
    },
  },
}
