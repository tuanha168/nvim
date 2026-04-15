local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/ethanholz/nvim-lastplace",
  "VimEnter",
  function()
    vim.schedule(function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      }
    end)
  end
)
