Chiruno = Chiruno or {}

local function file_worktree(file, worktrees)
  worktrees = worktrees or vim.g.git_worktrees
  if not worktrees then return end
  file = file or vim.fn.expand "%"
  for _, worktree in ipairs(worktrees) do
    if
      Chiruno.cmd({
        "git",
        "--work-tree",
        worktree.toplevel,
        "--git-dir",
        worktree.gitdir,
        "ls-files",
        "--error-unmatch",
        file,
      }, false)
    then
      return worktree
    end
  end
end

Chiruno.file_worktree = file_worktree

return Chiruno.file_worktree
