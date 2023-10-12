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

      vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        pattern = "*",
        callback = function(e)
          if vim.b[e.buf].scratch_entered then return end
          if string.find(vim.api.nvim_buf_get_name(e.buf), "scratch/src/scratch", 1, true) then
            vim.b[e.buf].scratch_entered = true
            local _ok, neo = pcall(require, "neo-tree.command")
            if _ok then neo.execute { action = "close" } end

            local splitLeft, splitRight = unpack(Chiruno.get_null_window_status())
            Chiruno.print(splitLeft)
            Chiruno.print(splitRight)
            Chiruno.close_null_window()
            vim.cmd "Codi"
            Chiruno.open_null_window()
          end
        end,
      })
    end,
  },
}
