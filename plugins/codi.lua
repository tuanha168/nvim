return {
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
    build = "npm install -g tsun",
    -- config = function() vim.g["codi#virtual_text"] = 0 end,
  },
  {
    "Vigemus/iron.nvim",
    cmd = "IronRepl",
    config = function()
      require("iron.core").setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
            typescript = {
              command = { "tsun" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").bottom(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        -- keymaps = {
        --   send_motion = "<space>sc",
        --   visual_send = "<space>sc",
        --   send_file = "<space>sf",
        --   send_line = "<space>sl",
        --   send_until_cursor = "<space>su",
        --   send_mark = "<space>sm",
        --   mark_motion = "<space>mc",
        --   mark_visual = "<space>mc",
        --   remove_mark = "<space>md",
        --   cr = "<space>s<cr>",
        --   interrupt = "<space>s<space>",
        --   exit = "<space>sq",
        --   clear = "<space>cl",
        -- },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }
    end,
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
        ext_options = { "lua", "js", "ts", "py", "cpp", "c" }, -- Options to choose from
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

            Chiruno.close_null_window()
            vim.cmd "IronRepl"
            Chiruno.open_null_window()
          end
        end,
      })
    end,
  },
}
