local logsDir = "~/.dotfile/logs/git-auto-push"

function Chiruno.auto_push(path)
  if vim.fn.executable "git-auto-push" == 1 then
    if not Chiruno.isdir_exist(logsDir) then vim.cmd("silent !mkdir " .. logsDir) end
    Chiruno.print("Auto Pushing " .. path)
    local folder_name = vim.fn.fnamemodify(path, ":t")
    local cmd = "silent !git-auto-push " .. path .. " >> " .. logsDir .. "/" .. folder_name .. ".log &"
    vim.cmd(cmd)
  end
end

return Chiruno.auto_push
