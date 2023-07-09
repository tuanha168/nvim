return {
  { "projekt0n/github-nvim-theme", config = function() require("github-theme").setup {} end },
  { "sekke276/dark_flat.nvim" },
  {
    "Mofiqul/dracula.nvim",
    opts = {
      -- customize dracula color palette
      colors = {
        bg = "#282A36",
        fg = "#F8F8F2",
        selection = "#44475A",
        comment = "#8896c2",
        red = "#BD93F9",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50fa7b",
        purple = "#FF79C6",
        cyan = "#8BE9FD",
        pink = "#FF5555",
        bright_red = "#FF6E6E",
        bright_green = "#69FF94",
        bright_yellow = "#FFFFA5",
        bright_blue = "#D6ACFF",
        bright_magenta = "#FF92DF",
        bright_cyan = "#A4FFFF",
        bright_white = "#FFFFFF",
        menu = "#21222C",
        visual = "#3E4452",
        gutter_fg = "#4B5263",
        nontext = "#3B4048",
      },
      -- show the '~' characters after the end of buffers
      show_end_of_buffer = true, -- default false
      -- use transparent background
      transparent_bg = true, -- default false
      -- set custom lualine background color
      lualine_bg_color = "#44475a", -- default nil
      -- set italic comment
      italic_comment = true, -- default false
      -- overrides the default highlights see `:h synIDattr`
      overrides = {
        -- Examples
        -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
        -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
        -- Nothing = {} -- clear highlight of Nothing
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local hl = require "utils.status.hl"
      local provider = require "utils.status.provider"
      local heirline = require "utils.status.heirline"
      local condition = require "utils.status.condition"
      local component = require "utils.status.component"
      local codeium = {
        provider = function()
          local success, output = pcall(vim.fn["codeium#GetStatusString"])
          if success then return output end
        end,
      }

      opts.statusline = {
        -- default highlight for the entire statusline
        hl = { fg = "fg", bg = "bg" },
        -- each element following is a component in utils.status module

        -- add the vim mode component
        component.mode {
          -- enable mode text with padding as well as an icon before it
          mode_text = { icon = { kind = "VimIcon", padding = { right = 1, left = 1 } } },
          -- surround the component with a separators
          surround = {
            -- it's a left element, so use the left separator
            separator = "left",
            -- set the color of the surrounding based on the current mode using utils.status module
            color = function() return { main = hl.mode_bg(), right = "blank_bg" } end,
          },
        },
        -- we want an empty space here so we can use the component builder to make a new section with just an empty string
        component.builder {
          { provider = "" },
          -- define the surrounding separator and colors to be used inside of the component
          -- and the color to the right of the separated out section
          surround = { separator = "left", color = { main = "blank_bg", right = "file_info_bg" } },
        },
        -- add a section for the currently opened file information
        component.file_info {
          -- enable the file_icon and disable the highlighting based on filetype
          file_icon = { padding = { left = 0 } },
          filename = { fallback = "Empty" },
          -- add padding
          padding = { right = 1 },
          -- define the section separator
          surround = { separator = "left", condition = false },
        },
        -- add a component for the current git branch if it exists and use no separator for the sections
        component.git_branch { surround = { separator = "none" } },
        -- add a component for the current git diff if it exists and use no separator for the sections
        component.git_diff { padding = { left = 1 }, surround = { separator = "none" } },
        -- fill the rest of the statusline
        -- the elements after this will appear in the middle of the statusline
        component.cmd_info(),
        component.fill(),
        codeium,
        -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
        component.lsp { lsp_client_names = false, surround = { separator = "none" } },
        -- fill the rest of the statusline
        -- the elements after this will appear on the right of the statusline
        component.fill(),
        -- add a component for the current diagnostics if it exists and use the right separator for the section
        component.diagnostics { padding = { right = 3 }, surround = { separator = "none" } },
        -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
        component.lsp { lsp_progress = false, surround = { separator = "none" } },
        -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
        -- all of the children of this table will be treated together as a single component
        {
          -- define a simple component where the provider is just a folder icon
          component.builder {
            -- get_icon gets the user interface icon for a closed folder with a space after it
            { provider = require("utils").get_icon "FolderClosed" },
            -- add padding after icon
            padding = { right = 1 },
            -- set the foreground color to be used for the icon
            hl = { fg = "bg" },
            -- use the right separator and define the background color
            surround = { separator = "right", color = "folder_icon_bg" },
          },
          -- add a file information component and only show the current working directory name
          component.file_info {
            -- we only want filename to be used and we can change the fname
            -- function to get the current working directory name
            filename = { fname = function(nr) return vim.fn.getcwd(nr) end, padding = { left = 1 } },
            -- disable all other elements of the file_info component
            file_icon = false,
            file_modified = false,
            file_read_only = false,
            -- use no separator for this part but define a background color
            surround = { separator = "none", color = "file_info_bg", condition = false },
          },
        },
        -- the final component of the NvChad statusline is the navigation section
        -- this is very similar to the previous current working directory section with the icon
        { -- make nav section with icon border
          -- define a custom component with just a file icon
          component.builder {
            { provider = require("utils").get_icon "ScrollText" },
            -- add padding after icon
            padding = { right = 1 },
            -- set the icon foreground
            hl = { fg = "bg" },
            -- use the right separator and define the background color
            -- as well as the color to the left of the separator
            surround = { separator = "right", color = { main = "nav_icon_bg", left = "file_info_bg" } },
          },
          -- add a navigation component and just display the percentage of progress in the file
          component.nav {
            -- add some padding for the percentage provider
            percentage = { padding = { right = 1 } },
            -- disable all other providers
            ruler = false,
            scrollbar = false,
            -- use no separator and define the background color
            surround = { separator = "none", color = "file_info_bg" },
          },
        },
      }
      -- opts.tabline = { -- bufferline
      --   { -- file tree padding
      --     condition = function(self)
      --       self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
      --       return condition.buffer_matches(
      --         { filetype = { "aerial", "dapui_.", "dap-repl", "neo%-tree", "NvimTree", "edgy" } },
      --         vim.api.nvim_win_get_buf(self.winid)
      --       )
      --     end,
      --     provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
      --     hl = { bg = "tabline_bg" },
      --   },
      --   heirline.make_buflist(component.tabline_file_info()), -- component for each buffer tab
      --   component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
      --   { -- tab list
      --     condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
      --     heirline.make_tablist { -- component for each tab
      --       provider = provider.tabnr(),
      --       hl = function(self) return hl.get_attributes(heirline.tab_type(self, "tab"), true) end,
      --     },
      --     { -- close button for current tab
      --       provider = provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
      --       hl = hl.get_attributes("tab_close", true),
      --       on_click = {
      --         callback = function() pcall(MiniBufremove.delete) end,
      --         name = "heirline_tabline_close_tab_callback",
      --       },
      --     },
      --   },
      -- }
      opts.winbar = { -- winbar
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        fallthrough = false,
        {
          condition = function() return not condition.is_active() end,
          component.separated_path(),
          component.file_info {
            file_icon = { hl = hl.file_icon "winbar", padding = { left = 0 } },
            file_modified = false,
            file_read_only = false,
            hl = hl.get_attributes("winbarnc", true),
            surround = false,
            update = "BufEnter",
          },
        },
        component.breadcrumbs { hl = hl.get_attributes("winbar", true) },
      }

      opts.statuscolumn = vim.fn.has "nvim-0.9" == 1
          and {
            component.foldcolumn(),
            component.fill(),
            component.numbercolumn(),
            component.signcolumn(),
          }
        or nil
      return opts
    end,
    config = require "config.heirline",
  },
}
