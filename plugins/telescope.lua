-- local locate = function()
--   local search = vim.fn.input { prompt = "Search files: " }
--   vim.cmd(vim.api.nvim_replace_termcodes("Telescope locate file=" .. search, true, true, true))
-- end

return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    opts = function(_, opts)
      opts.defaults.initial_mode = "normal"
      opts.defaults.vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!.git",
      }
    end,
  },
  -- {
  --   "nvim-telescope/telescope-project.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   lazy = false,
  --   config = function() require("telescope").load_extension "project" end,
  -- },
  -- {
  --   "aaronhallaert/advanced-git-search.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   config = function() require("telescope").load_extension "advanced_git_search" end,
  -- },
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = function()
      require("yanky").setup {
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
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 200,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      }
    end,
    config = function()
      require("telescope").load_extension "yank_history"
      vim.keymap.set("n", "<c-p>", "<cmd>Telescope yank_history<cr><esc>", { silent = true })
      vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
      -- vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      -- vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    end,
  },
  -- {
  --   "chikko80/error-lens.nvim",
  --   event = "BufRead",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   opts = {
  --     enabled = false,
  --   },
  -- },
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
