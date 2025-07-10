return {
  {
    "rebelot/heirline.nvim",
    dependencies = {
      "zeioth/heirline-components.nvim",
      "nvim-tree/nvim-web-devicons",
      { "stevearc/aerial.nvim", opts = {} },
    },
    event = "VeryLazy",
    keys = {
      {
        "<Tab>",
        function() require("heirline-components.buffer").nav(1) end,
        desc = "Move to next buffer",
      },
      {
        "<S-Tab>",
        function() require("heirline-components.buffer").nav(-1) end,
        desc = "Move to previous buffer",
      },
    },
    opts = function()
      local lib = require "heirline-components.all"
      local CodeCompanion = {
        static = {
          processing = false,
        },
        update = {
          "User",
          pattern = "CodeCompanionRequest*",
          callback = function(self, args)
            if args.match == "CodeCompanionRequestStarted" then
              self.processing = true
            elseif args.match == "CodeCompanionRequestFinished" then
              self.processing = false
            end
            vim.cmd "redrawstatus"
          end,
        },
        {
          condition = function(self) return self.processing end,
          provider = "  Requesting...",
          hl = { fg = "yellow" },
        },
      }

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
          lib.component.tabline_buffers {
            condition = function(buf)
              return not lib.condition.buffer_matches({
                buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
                filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
              }, buf.bufnr)
            end,
          },
          lib.component.fill { hl = { bg = "tabline_bg" } },
          lib.component.tabline_tabpages(),
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
          CodeCompanion,
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
    end,
  },
}
