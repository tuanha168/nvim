local function get_unique_path(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local filename = vim.fn.fnamemodify(filepath, ":t")      -- Get just the filename
  local full_path = vim.fn.fnamemodify(filepath, ":.:h")   -- Relative path excluding filename

  -- Collect all buffers with their filenames and full paths
  local buffers = vim.api.nvim_list_bufs()
  local file_map = {}

  for _, b in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(b) then
      local b_filepath = vim.api.nvim_buf_get_name(b)
      local b_filename = vim.fn.fnamemodify(b_filepath, ":t")
      local b_path = vim.fn.fnamemodify(b_filepath, ":.:h")

      if not file_map[b_filename] then
        file_map[b_filename] = {}
      end
      table.insert(file_map[b_filename], b_path)
    end
  end

  -- If filename is unique, return just the filename
  if #file_map[filename] == 1 then
    return filename
  end

  -- Find minimal unique path by comparing directories
  local function find_minimal_unique_path(paths, target_path)
    local path_parts = vim.split(target_path, "/", { plain = true })
    local min_unique = {}

    for level = #path_parts, 1, -1 do
      local candidate = table.concat(vim.list_slice(path_parts, 1, level), "/") .. "/.."
      local unique = true

      for _, other_path in ipairs(paths) do
        if other_path ~= target_path and vim.startswith(other_path, candidate) then
          unique = false
          break
        end
      end

      if unique then
        return candidate
      end
    end

    return target_path     -- fallback (shouldn't happen)
  end

  local minimal_path = find_minimal_unique_path(file_map[filename], full_path)
  return minimal_path .. "/" .. filename
end

return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local utils = require("heirline.utils")

      local leftDelimiter = { provider = "   ", hl = "red" }
      local rightDelimiter = { provider = "   ", hl = "red" }

      local TablineBufnr = {
        provider = function(self) return tostring(self.bufnr) .. ". " end,
      }

      -- we redefine the filename component, as we probably only want the tail and not the relative path
      local TablineFileName = {
        provider = function(self)
          return " " .. get_unique_path(self.bufnr) .. " "
        end,
        hl = function(self) return { bold = self.is_active or self.is_visible, italic = true } end,
      }

      -- this looks exactly like the FileFlags component that we saw in
      -- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
      -- also, we are adding a nice icon for terminal buffers.
      local TablineFileFlags = {
        {
          condition = function(self) return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
          provider = "   ",
          hl = { fg = "red" },
        },
        {
          condition = function(self)
            return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
                or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
          end,
          provider = function(self)
            if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
              return "  "
            else
              return ""
            end
          end,
          hl = { fg = "orange" },
        },
      }

      local FileIcon = {
        init = function(self)
          local filename = self.filename
          local extension = vim.fn.fnamemodify(filename, ":e")
          self.icon, self.icon_color =
              require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self) return self.icon and (self.icon .. " ") end,
        hl = function(self) return { fg = self.icon_color } end,
      }

      -- Here the filename block finally comes together
      local TablineFileNameBlock = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
        hl = function(self)
          if self.is_active then
            return { fg = "cyan" }
            -- why not?
            -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
            --     return { fg = "gray" }
          else
            return "TabLine"
          end
        end,
        on_click = {
          callback = function(_, minwid, _, button)
            if button == "m" then -- close on mouse middle click
              vim.schedule(function() vim.api.nvim_buf_delete(minwid, { force = false }) end)
            else
              vim.api.nvim_win_set_buf(0, minwid)
            end
          end,
          minwid = function(self) return self.bufnr end,
          name = "heirline_tabline_buffer_callback",
        },
        TablineBufnr,
        FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
        TablineFileName,
        TablineFileFlags,
      }

      -- a nice "x" button to close the buffer
      local TablineCloseButton = {
        condition = function(self) return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
        { provider = " " },
        {
          provider = "",
          hl = { fg = "gray" },
          on_click = {
            callback = function(_, minwid)
              vim.schedule(function()
                vim.api.nvim_buf_delete(minwid, { force = false })
                vim.cmd.redrawtabline()
              end)
            end,
            minwid = function(self) return self.bufnr end,
            name = "heirline_tabline_close_buffer_callback",
          },
        },
      }

      -- The final touch!
      local TablineBufferBlock = utils.surround({ leftDelimiter.provider, rightDelimiter.provider }, function(self)
        if self.is_active then
          if self.provider == leftDelimiter.provider then return leftDelimiter.hl end
          if self.provider == rightDelimiter.provider then return rightDelimiter.hl end
        else
          if self.provider == leftDelimiter.provider then return utils.get_highlight("Comment").fg end
          if self.provider == rightDelimiter.provider then return utils.get_highlight("Comment").fg end
        end

        return utils.get_highlight("TabLine").bg
      end, { TablineFileNameBlock, TablineCloseButton })

      -- and here we go
      local BufferLine = utils.make_buflist(
        TablineBufferBlock,
        { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
        { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
      -- by the way, open a lot of buffers and try clicking them ;)
      )

      require("heirline").setup {
        tabline = { BufferLine },
        color = {
          {
            bright_bg = utils.get_highlight("Folded").bg,
            bright_fg = utils.get_highlight("Folded").fg,
            red = utils.get_highlight("DiagnosticError").fg,
            dark_red = utils.get_highlight("DiffDelete").bg,
            green = utils.get_highlight("String").fg,
            blue = utils.get_highlight("Function").fg,
            gray = utils.get_highlight("NonText").fg,
            orange = utils.get_highlight("Constant").fg,
            purple = utils.get_highlight("Statement").fg,
            cyan = utils.get_highlight("Special").fg,
            diag_warn = utils.get_highlight("DiagnosticWarn").fg,
            diag_error = utils.get_highlight("DiagnosticError").fg,
            diag_hint = utils.get_highlight("DiagnosticHint").fg,
            diag_info = utils.get_highlight("DiagnosticInfo").fg,
            git_del = utils.get_highlight("diffDeleted").fg,
            git_add = utils.get_highlight("diffAdded").fg,
            git_change = utils.get_highlight("diffChanged").fg,
          },
        },
      }

      vim.o.showtabline = 2
      vim.cmd [[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]
    end,
  },
}
