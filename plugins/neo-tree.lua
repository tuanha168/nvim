return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem.filtered_items = {
        hide_dotfiles = false,
      }
      opts.source_selector = {
        winbar = false,
      }
      -- opts.window.position = "float"
      return opts
    end,
    keys = {
      {
        "<c-n>",
        function()
          local ok, neo = pcall(require, "neo-tree.command")
          if ok then neo.execute { toggle = true } end

          local Split = require "nui.split"
          local event = require("nui.utils.autocmd").event

          local highlights = require "neo-tree.ui.highlights"
          local split = Split {
            ns_id = highlights.ns_id,
            relative = "editor",
            position = "left",
            size = "20%",
            buf_options = {
              buftype = "nofile",
              modifiable = false,
              swapfile = false,
              filetype = "neo-tree",
              undolevels = -1,
            },
            win_options = {
              colorcolumn = "",
              signcolumn = "no",
            },
          }

          -- mount/open the component
          split:mount()

          -- unmount component when cursor leaves buffer
          vim.api.nvim_create_autocmd("Neotree", {
            pattern = "*",
            callback = function(e)
              Chiruno.print(e)
              split:unmount()
            end,
            group = vim.api.nvim_create_augroup("NeoTree", { clear = true }),
          })
        end,
        desc = "Neo Tree",
      },
    },
  },

  -- {
  --   "folke/edgy.nvim",
  --   event = "VeryLazy",
  --   init = function()
  --     vim.opt.laststatus = 3
  --     vim.opt.splitkeep = "screen"
  --   end,
  --   opts = {
  --     left = {
  --       -- Neo-tree filesystem always takes half the screen height
  --       {
  --         title = "Neo-Tree",
  --         ft = "neo-tree",
  --         filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
  --         size = { height = 0.5 },
  --       },
  --       {
  --         title = "Neo-Tree Buffers",
  --         ft = "neo-tree",
  --         filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
  --         pinned = true,
  --         open = "Neotree position=top buffers",
  --       },
  --       {
  --         title = "Neo-Tree Git",
  --         ft = "neo-tree",
  --         filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
  --         pinned = true,
  --         open = "Neotree position=right git_status",
  --       },
  --       -- {
  --       --   ft = "Outline",
  --       --   pinned = true,
  --       --   open = "AerialOpen",
  --       -- },
  --       -- any other neo-tree windows
  --       "neo-tree",
  --     },
  --   },
  -- },
}
