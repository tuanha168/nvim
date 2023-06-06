Chiruno = Chiruno or {}

local function auto_push(path)
  if vim.fn.executable "git-auto-push" == 1 then
    Chiruno.print "Auto Pushing"
    vim.cmd('silent exec "!git-auto-push ' .. path .. ' &"')
  end
end

Chiruno.auto_push = auto_push

return Chiruno.auto_push
