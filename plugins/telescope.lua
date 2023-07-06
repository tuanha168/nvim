-- local locate = function()
--   local search = vim.fn.input { prompt = "Search files: " }
--   vim.cmd(vim.api.nvim_replace_termcodes("Telescope locate file=" .. search, true, true, true))
-- end

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.extensions_list = { "themes", "terms", "project", "advanced_git_search", "projections" }
      return opts
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = false,
    config = function() require("telescope").load_extension "project" end,
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require("telescope").load_extension "advanced_git_search" end,
  },
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      ring = {
        history_length = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
    },
    config = function()
      require("telescope").load_extension "yank_history"
      vim.keymap.set({ "n", "x" }, "<c-p>", "<Plug>(YankyYank)")
    end,
  },
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
