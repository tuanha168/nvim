local logsDir = os.getenv "HOME" .. "/.dotfile/logs/git-auto-push"

function Chiruno.func.auto_push(path)
  local is_git_auto_push_available = vim.fn.executable "git-auto-push" == 1
  if is_git_auto_push_available then
    -- Ensure logs directory exists
    if not Chiruno.func.isdir_exist(logsDir) then vim.fn.mkdir(logsDir, "p") end

    -- Prepare log file and command
    local folder_name = vim.fn.fnamemodify(path, ":t")
    local log_file = string.format("%s/%s.log", logsDir, folder_name)
    local cmd = string.format("git-auto-push %s >> %s &", path, log_file)

    -- Start the job asynchronously
    vim.fn.jobstart(cmd, { detach = true })
  end
end

return Chiruno.func.auto_push
