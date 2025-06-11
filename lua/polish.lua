-- Create autocmds
local autocmds = require "autocmds"
for _, autocmd in pairs(autocmds) do
  vim.api.nvim_create_autocmd(
    autocmd[1],
    vim.tbl_deep_extend("force", autocmd.opts or {}, {
      callback = autocmd[2],
    })
  )
end

-- Create commands
local commands = require "commands"
for _, command in pairs(commands) do
  vim.api.nvim_create_user_command(command[1], command[2], vim.tbl_deep_extend("force", command.opts or {}, {}))
end

-- Add filetype
vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}
vim.filetype.add {
  pattern = { [".*%.env.*"] = "sh" },
}
