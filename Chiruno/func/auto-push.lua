Chiruno = Chiruno or {}

local function auto_push(path)
  if vim.fn.executable "git-auto-push" == 1 then
    Chiruno.print "Auto Pushing"
    local cmd = 'silent !sh -c \"git-auto-push ' .. path .. ' >> ~/.cache/git-auto-push.log &\"'
    vim.cmd(cmd)
  end
end

Chiruno.auto_push = auto_push

return Chiruno.auto_push
