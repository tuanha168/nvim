return {
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
    build = "npm install -g tsun",
  },
  {
    "0x100101/lab.nvim",
    cmd = "Lab",
    build = "cd js && npm ci",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
  {
    "m-demare/attempt.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    event = "BufReadPre",
    keys = {
      {
        "<leader>at",
        function()
          local ok, attempt = pcall(require, "attempt")
          if not ok then return end

          attempt.new_select()
        end,
        desc = "Attempt",
      },
      {
        "<leader>aa",
        function()
          local ok, builtin = pcall(require, "telescope.builtin")
          if not ok then return end

          builtin.find_files {
            prompt_title = "Attempt",
            search_dirs = { os.getenv "HOME" .. "/.config/nvim/lua/user/scratch/src" },
            cwd = os.getenv "HOME" .. "/.config/nvim/lua/user/scratch/src",
            follow = true,
            no_ignore_parent = true,
          }
        end,
        desc = "Telescope Attempt",
      },
    },
    config = function()
      require("attempt").setup {
        dir = os.getenv "HOME" .. "/.config/nvim/lua/user/scratch/src",
        ext_options = { "lua", "ts", "py" }, -- Options to choose from
        list_buffers = true,
      }

      -- vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      --   pattern = "*",
      --   callback = function(e)
      --     if vim.b[e.buf].scratch_entered then return end
      --     if string.find(vim.api.nvim_buf_get_name(e.buf), "scratch/src/scratch", 1, true) then
      --       vim.b[e.buf].scratch_entered = true
      --       local buffers = vim.fn.getwininfo()
      --       if not buffers then return end
      --       local haveNeoTree = false
      --       for _, buf in ipairs(buffers) do
      --         if vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr }) == "neo-tree" then
      --           haveNeoTree = true
      --         end
      --       end
      --       local _ok, neo = pcall(require, "neo-tree.command")
      --       if _ok then neo.execute { action = "close" } end
      --
      --       local status = Chiruno.func.get_null_window_status()
      --       Chiruno.func.close_null_window()
      --       vim.cmd "Codi"
      --       Chiruno.func.open_null_window { left = not not status.splitLeft, right = not not status.splitRight }
      --
      --       if _ok and haveNeoTree then neo.execute { action = "toggle" } end
      --     end
      --   end,
      -- })
    end,
  },
}
