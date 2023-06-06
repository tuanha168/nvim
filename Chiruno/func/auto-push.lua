Chiruno = Chiruno or {}

local function auto_push(path)
  if vim.fn.executable "git-auto-push" == 1 then
    vim.cmd('exec "!git-auto-push ' .. path .. '"')
    Chiruno.print "Auto Pushing"
  end
end

Chiruno.auto_push = auto_push

return Chiruno.auto_push
