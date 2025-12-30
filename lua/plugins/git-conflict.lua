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
  config = function(_, opts)
    require("git-conflict").setup(opts)

    vim.api.nvim_create_autocmd({ "FocusGained", "BufReadPost" }, {
      callback = function()
        vim.cmd "checktime"
        local ok, _ = pcall(require, "git-conflict")
        if not ok then return end
        vim.cmd "GitConflictRefresh"
      end,
    })
  end,
}
