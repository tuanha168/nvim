local logsDir = "~/.dotfile/logs/git-auto-push"

function Chiruno.func.auto_push(path)
  if vim.fn.executable "git-auto-push" == 1 then
    if not Chiruno.func.isdir_exist(logsDir) then vim.cmd("silent !mkdir " .. logsDir) end
    Chiruno.func.print("Auto Pushing " .. path)
    Chiruno.func.print("Auto Pushing ", path)
    local folder_name = vim.fn.fnamemodify(path, ":t")
    local cmd = "silent !git-auto-push " .. path .. " >> " .. logsDir .. "/" .. folder_name .. ".log &"
    vim.schedule(function() vim.cmd(cmd) end)
  end
end

return Chiruno.func.auto_push
