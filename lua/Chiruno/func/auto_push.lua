local logsDir = os.getenv("HOME") .. "/.dotfile/logs/git-auto-push"

function Chiruno.func.auto_push(path)
  if vim.fn.executable("git-auto-push") == 1 then
    if not Chiruno.func.isdir_exist(logsDir) then
      vim.fn.mkdir(logsDir, "p")
    end
    print("Auto Pushing", path)
    local folder_name = vim.fn.fnamemodify(path, ":t")
    local log_file = string.format("%s/%s.log", logsDir, folder_name)
    local cmd = string.format("git-auto-push %s >> %s &", path, log_file)
    vim.fn.jobstart(cmd, { detach = true })
  end
end

return Chiruno.func.auto_push
