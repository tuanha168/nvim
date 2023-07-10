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
      return opts
    end,
  },

  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
          size = { height = 0.5 },
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        -- {
        --   ft = "Outline",
        --   pinned = true,
        --   open = "AerialOpen",
        -- },
        -- any other neo-tree windows
        "neo-tree",
      },
    },
  },
}
