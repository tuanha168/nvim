return {
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
}
