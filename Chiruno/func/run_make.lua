Chiruno.run_make = function()
  local makeCommand = vim.fn.input { prompt = "Enter command: ", default = vim.g.chiruno_make_command }
  if makeCommand == "" then return end

  if (makeCommand == "vue-tsc") then
    makeCommand = "yarn lint:tsc --noEmit --pretty false | sed -E 's/\\(([[:digit:]]+),([[:digit:]]+)\\)/:\\1:\\2/'"
  elseif (makeCommand == "eslint") then
    makeCommand = "yarn lint:eslint --format unix"
  elseif (makeCommand == "stylelint") then
    makeCommand = "yarn lint:style --formatter unix"
  end

  vim.g.chiruno_make_command = makeCommand
  vim.o.makeprg = vim.g.chiruno_make_command
  vim.cmd "Make"
end
