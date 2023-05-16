local locate = function()
  local search = vim.fn.input { prompt = "Search files: " }
  vim.cmd(vim.api.nvim_replace_termcodes("Telescope locate file=" .. search, true, true, true))
end

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.extensions_list = { "themes", "terms", "project", "advanced_git_search" }
      local telescope = require "telescope"
      local utils = require "astronvim.utils"
      local conditional_func = utils.conditional_func
      conditional_func(telescope.load_extension, utils.is_available "telescope-project.nvim", "project")
      conditional_func(telescope.load_extension, utils.is_available "yanky.nvim", "yank_history")
      conditional_func(telescope.load_extension, utils.is_available "advanced-git-search.nvim", "advanced_git_search")
      conditional_func(telescope.load_extension, utils.is_available "telescope-file-history.nvim", "file_history")
      conditional_func(telescope.load_extension, utils.is_available "telescope-locate.nvim", "locate")
      return opts
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = false,
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  -- {
  --   "gbprod/yanky.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   opts = function() require("yanky").setup {} end,
  --   config = function() vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)") end,
  -- },
  {
    "chikko80/error-lens.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      enabled = false,
    },
  },
  -- {
  --   "dawsers/telescope-file-history.nvim",
  --   event = "BufRead",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("file_history").setup()
  --     vim.api.nvim_set_keymap("n", "<C-y>", "<cmd>Telescope file_history history<CR>", { silent = true })
  --   end,
  -- },
  -- {
  --   "dawsers/telescope-locate.nvim",
  --   keys = { "<leader>FF" },
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     vim.keymap.set("n", "<leader>FF", function() locate() end, { silent = true })
  --   end,
  -- },
}
