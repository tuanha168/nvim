-- local locate = function()
--   local search = vim.fn.input { prompt = "Search files: " }
--   vim.cmd(vim.api.nvim_replace_termcodes("Telescope locate file=" .. search, true, true, true))
-- end

---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "nvim-telescope/telescope-fzy-native.nvim"
      }
    },
    lazy = false,
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
      -- opts.extensions.fzf = {
      --   fuzzy = true,                   -- false will only do exact matching
      --   override_generic_sorter = true, -- override the generic sorter
      --   override_file_sorter = true,    -- override the file sorter
      --   case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      --   -- the default case_mode is "smart_case"
      -- }
      -- require("telescope").load_extension "fzf"
      opts.extensions.fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
      require("telescope").load_extension "fzy_native"
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
  {
    "vuki656/package-info.nvim",
    lazy = false,
    dependency = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup {
        colors = {
          up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
          outdated = "#d19a66",   -- Text color for outdated dependency virtual text
        },
        icons = {
          enable = true, -- Whether to display icons
          style = {
            up_to_date = "|  ", -- Icon for up to date dependencies
            outdated = "|  ", -- Icon for outdated dependencies
          },
        },
        autostart = true,               -- Whether to autostart when `package.json` is opened
        hide_up_to_date = false,        -- It hides up to date versions when displaying virtual text
        hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
        -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
        -- The plugin will try to auto-detect the package manager based on
        -- `yarn.lock` or `package-lock.json`. If none are found it will use the
        -- provided one, if nothing is provided it will use `yarn`
        package_manager = "yarn",
      }
      require("telescope").load_extension "package_info"
    end,
  },
}
