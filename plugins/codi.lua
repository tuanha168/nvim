return {
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
    build = "npm install -g tsun",
  },
  {
    "m-demare/attempt.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if not ok then return end
      telescope.load_extension "attempt"
    end,
  },
}
