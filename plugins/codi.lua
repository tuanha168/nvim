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
    keys = {
      {
        "<leader>at",
        function()
          local ok, attempt = pcall(require, "attempt")
          if not ok then return end
          attempt.setup()
          attempt.new_select()
        end,
        desc = "Attempt",
      },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if not ok then return end
      telescope.load_extension "attempt"
    end,
  },
}
