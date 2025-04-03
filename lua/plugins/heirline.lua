-- local function find_unique_subpath(target_path, paths)
--   local target_parts = vim.split(target_path, "/", { plain = true })
--   local split_paths = {}

--   -- Convert all paths into parts
--   for _, path in ipairs(paths) do
--     split_paths[path] = vim.split(path, "/", { plain = true })
--   end

--   -- Determine the longest common prefix
--   local min_common_level = 1
--   for _, other_parts in pairs(split_paths) do
--     if other_parts ~= target_parts then
--       for i = 1, math.min(#target_parts, #other_parts) do
--         if target_parts[i] ~= other_parts[i] then break end
--         min_common_level = i + 1
--       end
--     end
--   end

--   -- Ensure uniqueness by returning only the necessary subpath
--   return table.concat(vim.list_slice(target_parts, min_common_level, #target_parts), "/")
-- end

-- local function get_unique_path(bufnr)
--   local filepath = vim.api.nvim_buf_get_name(bufnr)
--   if filepath == "" then return "[No Name]" end

--   local filename = vim.fn.fnamemodify(filepath, ":t")
--   local full_path = vim.fn.fnamemodify(filepath, ":.:h")

--   local buffers = vim.api.nvim_list_bufs()
--   local file_map = {}

--   -- Build a map of filenames to all their directory paths
--   for _, b in ipairs(buffers) do
--     if vim.api.nvim_buf_is_loaded(b) then
--       local b_filepath = vim.api.nvim_buf_get_name(b)
--       if b_filepath ~= "" then
--         local b_filename = vim.fn.fnamemodify(b_filepath, ":t")
--         local b_path = vim.fn.fnamemodify(b_filepath, ":.:h")

--         if not file_map[b_filename] then file_map[b_filename] = {} end
--         table.insert(file_map[b_filename], b_path)
--       end
--     end
--   end

--   -- If the filename is unique, return it directly
--   if #file_map[filename] == 1 then return filename end

--   -- Otherwise, determine the minimal unique path
--   local paths = file_map[filename]
--   local minimal_path = find_unique_subpath(full_path, paths)

--   return minimal_path .. "/" .. filename
-- end

return {
  {
    "rebelot/heirline.nvim",
    dependencies = {
      "zeioth/heirline-components.nvim",
      "nvim-tree/nvim-web-devicons",
      { "stevearc/aerial.nvim", opts = {} },
    },
    event = "VeryLazy",
    opts = function()
      -- local utils = require "heirline.utils"

      -- local leftDelimiter = { provider = "   ", hl = "red" }
      -- local rightDelimiter = { provider = "   ", hl = "red" }

      -- local TablineBufnr = {
      --   provider = function(self) return tostring(self.bufnr) .. ". " end,
      -- }

      -- -- we redefine the filename component, as we probably only want the tail and not the relative path
      -- local TablineFileName = {
      --   provider = function(self) return " " .. get_unique_path(self.bufnr) .. " " end,
      --   hl = function(self) return { bold = self.is_active or self.is_visible, italic = true } end,
      -- }

      -- -- this looks exactly like the FileFlags component that we saw in
      -- -- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
      -- -- also, we are adding a nice icon for terminal buffers.
      -- local TablineFileFlags = {
      --   {
      --     condition = function(self) return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
      --     provider = "   ",
      --     hl = { fg = "red" },
      --   },
      --   {
      --     condition = function(self)
      --       return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
      --         or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
      --     end,
      --     provider = function(self)
      --       if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
      --         return "  "
      --       else
      --         return ""
      --       end
      --     end,
      --     hl = { fg = "orange" },
      --   },
      -- }

      -- local FileIcon = {
      --   init = function(self)
      --     local filename = self.filename
      --     local extension = vim.fn.fnamemodify(filename, ":e")
      --     self.icon, self.icon_color =
      --       require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      --   end,
      --   provider = function(self) return self.icon and (self.icon .. " ") end,
      --   hl = function(self) return { fg = self.icon_color } end,
      -- }

      -- -- Here the filename block finally comes together
      -- local TablineFileNameBlock = {
      --   init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
      --   hl = function(self)
      --     if self.is_active then
      --       return { fg = "cyan" }
      --       -- why not?
      --       -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
      --       --     return { fg = "gray" }
      --     else
      --       return "TabLine"
      --     end
      --   end,
      --   on_click = {
      --     callback = function(_, minwid, _, button)
      --       if button == "m" then -- close on mouse middle click
      --         vim.schedule(function() vim.api.nvim_buf_delete(minwid, { force = false }) end)
      --       else
      --         vim.api.nvim_win_set_buf(0, minwid)
      --       end
      --     end,
      --     minwid = function(self) return self.bufnr end,
      --     name = "heirline_tabline_buffer_callback",
      --   },
      --   TablineBufnr,
      --   FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
      --   TablineFileName,
      --   TablineFileFlags,
      -- }

      -- -- a nice "x" button to close the buffer
      -- local TablineCloseButton = {
      --   condition = function(self) return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
      --   { provider = " " },
      --   {
      --     provider = "",
      --     hl = { fg = "gray" },
      --     on_click = {
      --       callback = function(_, minwid)
      --         vim.schedule(function()
      --           vim.api.nvim_buf_delete(minwid, { force = false })
      --           vim.cmd.redrawtabline()
      --         end)
      --       end,
      --       minwid = function(self) return self.bufnr end,
      --       name = "heirline_tabline_close_buffer_callback",
      --     },
      --   },
      -- }

      -- -- The final touch!
      -- local TablineBufferBlock = utils.surround({ leftDelimiter.provider, rightDelimiter.provider }, function(self)
      --   if self.is_active then
      --     if self.provider == leftDelimiter.provider then return leftDelimiter.hl end
      --     if self.provider == rightDelimiter.provider then return rightDelimiter.hl end
      --   else
      --     if self.provider == leftDelimiter.provider then return utils.get_highlight("Comment").fg end
      --     if self.provider == rightDelimiter.provider then return utils.get_highlight("Comment").fg end
      --   end

      --   return utils.get_highlight("TabLine").bg
      -- end, { TablineFileNameBlock, TablineCloseButton })

      -- -- and here we go
      -- local BufferLine = utils.make_buflist(
      --   TablineBufferBlock,
      --   { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
      --   { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
      --   -- by the way, open a lot of buffers and try clicking them ;)
      -- )
      local lib = require "heirline-components.all"

      return {
        opts = {
          disable_winbar_cb = function(args) -- We do this to avoid showing it on the greeter.
            local is_disabled = not require("heirline-components.buffer").is_valid(args.buf)
              or lib.condition.buffer_matches({
                buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
                filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
              }, args.buf)
            return is_disabled
          end,
        },
        tabline = { -- UI upper bar
          lib.component.tabline_conditional_padding(),
          lib.component.tabline_buffers(),
          lib.component.fill { hl = { bg = "tabline_bg" } },
          lib.component.tabline_tabpages(),
        },
        -- tabline = { BufferLine },
        winbar = { -- UI breadcrumbs bar
          init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
          fallthrough = false,
          -- Winbar for terminal, neotree, and aerial.
          {
            condition = function() return not lib.condition.is_active() end,
            {
              lib.component.neotree(),
              lib.component.compiler_play(),
              lib.component.fill(),
              lib.component.compiler_build_type(),
              lib.component.compiler_redo(),
              lib.component.aerial(),
            },
          },
          -- Regular winbar
          {
            -- lib.component.neotree(),
            -- lib.component.compiler_play(),
            lib.component.fill(),
            lib.component.breadcrumbs(),
            lib.component.fill(),
            -- lib.component.compiler_redo(),
            lib.component.aerial(),
          },
        },
        statuscolumn = { -- UI left column
          init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
          lib.component.foldcolumn(),
          lib.component.numbercolumn(),
          lib.component.signcolumn(),
        } or nil,
        statusline = { -- UI statusbar
          hl = { fg = "fg", bg = "bg" },
          lib.component.mode(),
          lib.component.git_branch(),
          lib.component.file_info(),
          lib.component.git_diff(),
          lib.component.diagnostics(),
          lib.component.fill(),
          lib.component.cmd_info(),
          lib.component.fill(),
          lib.component.lsp(),
          lib.component.compiler_state(),
          lib.component.virtual_env(),
          lib.component.nav(),
          lib.component.mode { surround = { separator = "right" } },
        },
      }
    end,
    config = function(_, opts)
      local heirline = require "heirline"
      local heirline_components = require "heirline-components.all"

      -- Setup
      heirline_components.init.subscribe_to_events()
      heirline.load_colors(heirline_components.hl.get_colors())
      heirline.setup(opts)

      vim.o.showtabline = 2
      vim.cmd [[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]

      -- vim.keymap.set("n", "gbp", function()
      --   local tabline = require("heirline").tabline
      --   local buflist = tabline._buflist[1]
      --   buflist._picker_labels = {}
      --   buflist._show_picker = true
      --   vim.cmd.redrawtabline()
      --   local char = vim.fn.getcharstr()
      --   local bufnr = buflist._picker_labels[char]
      --   if bufnr then vim.api.nvim_win_set_buf(0, bufnr) end
      --   buflist._show_picker = false
      --   vim.cmd.redrawtabline()
      -- end)
    end,
  },
}
