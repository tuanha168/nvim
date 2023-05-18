Chiruno.run_make = function()
  local makeCommand = vim.fn.input { prompt = "Enter command: ", default = vim.g.chiruno_make_command }
  if makeCommand == "" then return end

  vim.g.chiruno_make_command = makeCommand
  vim.o.makeprg = vim.g.chiruno_make_command
  vim.cmd "Make"
end
