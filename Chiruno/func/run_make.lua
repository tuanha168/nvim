Chiruno.run_make = function()
  local makeCommand = vim.fn.input { prompt = "Enter command: ", default = vim.g.chiruno_make_command }
  if makeCommand == "" then return end

  if string.find(makeCommand, "vue-tsc", 1, true) ~= nil then
    makeCommand = string.gsub(
      makeCommand,
      "vue%-tsc",
      "yarn lint:tsc --noEmit --pretty false | sed -E 's/\\(([[:digit:]]+),([[:digit:]]+)\\)/:\\1:\\2/'"
    )
  elseif string.find(makeCommand, "eslint", 1, true) ~= nil then
    makeCommand = string.gsub(makeCommand, "eslint", "yarn lint:eslint --format unix")
  elseif string.find(makeCommand, "stylelint", 1, true) ~= nil then
    makeCommand = string.gsub(makeCommand, "stylelint", "yarn lint:style --formatter unix")
  end

  vim.g.chiruno_make_command = makeCommand
  vim.o.makeprg = vim.g.chiruno_make_command
  vim.cmd "Make"
end
