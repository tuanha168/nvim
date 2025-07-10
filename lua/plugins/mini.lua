---@type LazySpec
return {
  -- {
  --   "echasnovski/mini.ai",
  --   config = function() require("mini.ai").setup() end,
  --   event = "BufRead",
  -- },

  -- {
  --   "echasnovski/mini.bufremove",
  --   opts = {
  --     silent = true,
  --   },
  -- },

  {
    "echasnovski/mini.files",
    keys = {
      {
        "<c-n>",
        function()
          local ok, minifiles = pcall(require, "mini.files")
          if not ok then return end
          local status, _ = pcall(minifiles.open, vim.api.nvim_buf_get_name(0), true)
          if not status then minifiles.open(nil, false) end
          minifiles.reveal_cwd()
        end,
        desc = "Open mini.files (directory of current file)",
        mode = "n",
      },
    },
    opts = function()
      vim.g.mini_files_ignore = false
      local ok, minifiles = pcall(require, "mini.files")
      if not ok then return end

      local git_ignore_sorter = function(entries)
        -- technically can filter entries here too, and checking gitignore for _every entry individually_
        -- like I would have to in `content.filter` above is too slow. Here we can give it _all_ the entries
        -- at once, which is much more performant.
        local all_paths = table.concat(vim.tbl_map(function(entry) return entry.path end, entries), "\n")
        local output_lines = {}
        local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
          stdout_buffered = true,
          on_stdout = function(_, data) output_lines = data end,
        })

        -- command failed to run
        if job_id < 1 then return entries end

        -- send paths via STDIN
        vim.fn.chansend(job_id, all_paths)
        vim.fn.chanclose(job_id, "stdin")
        vim.fn.jobwait { job_id }
        return require("mini.files").default_sort(
          vim.tbl_filter(function(entry) return not vim.tbl_contains(output_lines, entry.path) end, entries)
        )
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set("n", "H", function()
            vim.g.mini_files_ignore = not vim.g.mini_files_ignore

            minifiles.refresh {
              content = {
                sort = vim.g.mini_files_ignore and git_ignore_sorter or minifiles.default_sort,
              },
            }
          end, { buffer = buf_id })

          vim.keymap.set("n", "<c-n>", function() minifiles.close() end, { buffer = buf_id })

          vim.keymap.set("n", "<CR>", function()
            local fs_entry = minifiles.get_fs_entry()
            local is_at_file = fs_entry ~= nil and fs_entry.fs_type == "file"
            minifiles.go_in {}
            if is_at_file then minifiles.close() end
          end, { buffer = buf_id })

          vim.keymap.set("n", ".", function()
            local fs_entry = minifiles.get_fs_entry()
            if fs_entry == nil or fs_entry.fs_type == "file" then return end

            minifiles.go_in {}
            local cur_entry_path = minifiles.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
            minifiles.open(cur_directory, false)
          end, { buffer = buf_id })

          vim.keymap.set("n", "t", function()
            minifiles.close()
            local status, _ = pcall(minifiles.open, vim.api.nvim_buf_get_name(0), true)
            if not status then minifiles.open(nil, false) end
            minifiles.reveal_cwd()
          end, { buffer = buf_id })

          vim.keymap.set("n", "r", function()
            minifiles.close()
            minifiles.open(nil, false)
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
            Print(path)
          end, { buffer = buf_id })

          vim.keymap.set("n", "<Leader>yy", function()
            -- Get the current entry (file or directory)
            local curr_entry = minifiles.get_fs_entry()
            if curr_entry then
              local path = curr_entry.path
              vim.fn.setreg("+", path)
              Print(path)
            else
              vim.notify("No file or directory selected", vim.log.levels.WARN)
            end
          end, { buffer = buf_id, noremap = true, silent = true, desc = "Copy file/directory to clipboard" })

          vim.keymap.set("n", "<Leader>p", function()
            -- vim.notify("Starting the paste operation...", vim.log.levels.INFO)

            local curr_entry = minifiles.get_fs_entry() -- Get the current file system entry
            if not curr_entry then
              vim.notify("Failed to retrieve current entry in mini.files.", vim.log.levels.ERROR)
              return
            end
            local curr_dir = curr_entry.fs_type == "directory" and curr_entry.path
              or vim.fn.fnamemodify(curr_entry.path, ":h") -- Use parent directory if entry is a file
            -- vim.notify("Current directory: " .. curr_dir, vim.log.levels.INFO)
            local output = vim.fn.getreg "+" -- Execute AppleScript command
            local source_path = output:gsub("%s+$", "") -- Trim whitespace from clipboard output

            if source_path == "" or not Chiruno.func.file_exist(source_path) then
              Print("Clipboard is empty or invalid.", source_path)
              return
            end

            local dest_path = curr_dir .. "/" .. vim.fn.fnamemodify(source_path, ":t") -- Destination path in current directory

            local copy_cmd = vim.fn.isdirectory(source_path) == 1 and { "cp", "-r", source_path, dest_path }
              or { "cp", source_path, dest_path } -- Construct copy command
            local result = vim.system(copy_cmd) -- Execute the copy command
            if vim.v.shell_error ~= 0 then
              vim.notify("Paste operation failed: " .. result, vim.log.levels.ERROR)
              return
            end
            -- vim.notify("Pasted " .. source_path .. " to " .. dest_path, vim.log.levels.INFO)
            minifiles.synchronize() -- Refresh mini.files to show updated directory content
            vim.notify("Pasted successfully.", vim.log.levels.INFO)
          end, { buffer = buf_id, noremap = true, silent = true, desc = "Paste from clipboard" })

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
          if Snacks then Snacks.rename.on_rename_file(event.data.from, event.data.to) end
        end,
      })

      return {
        content = {
          filter = function(entry) return entry.name ~= ".DS_Store" end,
          sort = vim.g.mini_files_ignore and git_ignore_sorter or minifiles.default_sort,
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

  {
    "echasnovski/mini.diff",
    version = "*",
    config = function()
      local diff = require "mini.diff"
      diff.setup {
        -- Disabled by default
        source = diff.gen_source.none(),
      }
    end,
  },

  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
