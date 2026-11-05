vim.cmd [[packadd nvim.difftool]]

local lazy = require("pack.lazy-load")

local commands = {
  "DiffBandit",
  "DiffBanditBuffers",
  "DiffBanditFolderDiff",
  "DiffBanditGit",
  "DiffBanditGitCurrent",
  "DiffBanditCommitPanel",
  "DiffBanditGitMenu",
  "DiffBanditGitLog",
  "DiffBanditGitCommit",
  "DiffBanditGitCompare",
  "DiffBanditGitCheckout",
  "DiffBanditMerge",
}

for _, cmd in ipairs(commands) do
  lazy.on_command("https://github.com/CoreyKaylor/diffbandit.nvim", cmd, function()
    require("diffbandit").setup {
      merge = {
        keys = {
          next_conflict = "n",
          prev_conflict = "N",
          accept_local = "co",
          accept_remote = "ci",
          accept_both = "<CR>",
        },
      },
    }
  end, { nargs = "*", range = true, complete = "file" })
end
