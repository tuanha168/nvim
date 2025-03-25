return {
  "akinsho/git-conflict.nvim",
  event = "BufRead",
  opts = {
    default_mappings = {
      ours = "cc",
      theirs = "ic",
      none = "dd",
      both = "<Enter>",
      next = "n",
      prev = "N",
    },
    disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = { -- They must have background color, otherwise the default color will be used
      incoming = "DiffDelete",
      current = "DiffText",
    },
  },
}
