-- local locate = function()
--   local search = vim.fn.input { prompt = "Search files: " }
--   vim.cmd(vim.api.nvim_replace_termcodes("Telescope locate file=" .. search, true, true, true))
-- end
local enable_telescope = false

---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = enable_telescope,
    opts = function(_, opts)
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
      opts.extensions = opts.extensions or {}
      opts.extensions.fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
      require("telescope").load_extension "fzf"
    end,
    keys = {
      {
        "<Leader>fa",
        function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
        desc = "Find all files",
      },
      {
        "<Leader>ff",
        function() require("telescope.builtin").find_files() end,
        desc = "Find files",
      },
      {
        "<Leader>fs",
        mode = { "n", "v" },
        function() Chiruno.func.operatorfunc_lua "live_grep_motion" end,
        desc = "Live grep motion",
        noremap = true,
      },
    },
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
    enabled = enable_telescope,
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
