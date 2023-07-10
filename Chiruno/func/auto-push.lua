Chiruno = Chiruno or {}

local function auto_push(path)
  if vim.fn.executable "git-auto-push" == 1 then
    if not Chiruno.isdir_exist "~/.cache/git-auto-push" then vim.cmd "silent !mkdir ~/.cache/git-auto-push" end
    Chiruno.print("Auto Pushing " .. path)
    local folder_name = vim.fn.fnamemodify(path, ":t")
    local cmd = "silent !git-auto-push " .. path .. " >> ~/.cache/git-auto-push/" .. folder_name .. ".log &"
    vim.cmd(cmd)
  end
end

Chiruno.auto_push = auto_push

return Chiruno.auto_push
