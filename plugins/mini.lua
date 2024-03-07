return {
  {
    "echasnovski/mini.ai",
    config = function() require("mini.ai").setup() end,
    event = "BufRead",
  },

  {
    "echasnovski/mini.bufremove",
    opts = {
      silent = true,
    },
  },

  {
    "echasnovski/mini.files",
    dependencies = {
      { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    },
    keys = {
      {
        "<c-n>",
        function()
          local ok, minifiles = pcall(require, "mini.files")
          if not ok then return end
          minifiles.open(vim.api.nvim_buf_get_name(0), true)
          minifiles.reveal_cwd()
        end,
        desc = "Open mini.files (directory of current file)",
        mode = "n",
      },
    },
    opts = function()
      vim.b.mini_files_ignore = false
      local ok, minifiles = pcall(require, "mini.files")
      if not ok then return end

      local ignored_entries = {}
      local get_ignore_entries = function(entries)
        local all_paths = table.concat(vim.tbl_map(function(entry) return entry.path end, entries), "\n")
        local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
          stdout_buffered = true,
          on_stdout = function(_, data) ignored_entries = data end,
        })

        -- command failed to run
        if job_id < 1 then return entries end

        -- send paths via STDIN
        vim.fn.chansend(job_id, all_paths)
        vim.fn.chanclose(job_id, "stdin")
        vim.fn.jobwait { job_id }
      end

      local git_ignore_sorter = function(entries)
        get_ignore_entries(entries)

        return minifiles.default_sort(
          vim.tbl_filter(function(entry) return not vim.tbl_contains(ignored_entries, entry.path) end, entries)
        )
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set("n", "H", function()
            vim.b.mini_files_ignore = not vim.b.mini_files_ignore

            minifiles.refresh {
              content = {
                sort = vim.b.mini_files_ignore and git_ignore_sorter or minifiles.default_sort,
                prefix = function(entry)
                  Print(entry)
                  if vim.tbl_contains(ignored_entries, entry.path) then
                    Print(ignored_entries)
                    return " ", "MiniFilesDirectory"
                  end

                  return minifiles.default_prefix(entry)
                end,
              },
            }
          end, { buffer = buf_id })

          vim.keymap.set("n", "<c-n>", function() minifiles.close() end, { buffer = buf_id })

          vim.keymap.set("n", "<CR>", function()
            local fs_entry = minifiles.get_fs_entry()
            local is_at_file = fs_entry ~= nil and fs_entry.fs_type == "file"
            minifiles.go_in()
            if is_at_file then minifiles.close() end
          end, { buffer = buf_id })

          vim.keymap.set("n", ".", function()
            local fs_entry = minifiles.get_fs_entry()
            if fs_entry == nil or fs_entry.fs_type == "file" then return end

            minifiles.go_in()
            local cur_entry_path = minifiles.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
            minifiles.open(cur_directory, false)
          end, { buffer = buf_id })

          vim.keymap.set("n", "r", function()
            minifiles.close()
            minifiles.open(vim.api.nvim_buf_get_name(0), true)
            minifiles.reveal_cwd()
          end, { buffer = buf_id })

          vim.keymap.set("n", "<BS>", function()
            minifiles.open()
            minifiles.go_out()
            local cur_entry_path = minifiles.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
            minifiles.open(cur_directory, false)
          end, { buffer = buf_id })

          vim.keymap.set("n", "<c-o>", function()
            local path = minifiles.get_fs_entry().path
            local have_plenary, Path = pcall(require, "plenary.path")
            if have_plenary then path = Path:new(path):make_relative(vim.fn.getcwd()) end
            vim.fn.setreg("+", path)
            Chiruno.func.print(path)
          end, { buffer = buf_id })

          -- vim.schedule(function()
          --   vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf_id })
          --   vim.api.nvim_buf_set_name(buf_id, minifiles.get_fs_entry(buf_id, 1).path)
          --   vim.api.nvim_create_autocmd("BufWriteCmd", {
          --     buffer = buf_id,
          --     callback = function() minifiles.synchronize() end,
          --   })
          -- end)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          vim.defer_fn(function() Chiruno.lsp.on_rename(event.data.from, event.data.to) end, 0)
        end,
      })
      return {
        content = {
          filter = function(entry) return entry.name ~= ".DS_Store" end,
          sort = vim.b.mini_files_ignore and git_ignore_sorter or minifiles.default_sort,
        },
        mappings = {
          close = "q",
          go_in = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },
        windows = {
          preview = true,
          width_preview = 50,
          width_nofocus = 25,
          width_focus = 50,
        },
      }
    end,
  },

  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
