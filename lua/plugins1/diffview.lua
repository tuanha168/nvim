return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  config = function()
    require("diffview").setup {
      diff_binaries = false, -- Show diffs for binaries
      enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
      git_cmd = { "git" }, -- The git executable for diffview (if not in PATH)
      use_icons = true, -- Requires nvim-web-devicons
      watch_index = true, -- Update the diff view as files change
      icons = { -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
      },
    }
  end,
}
