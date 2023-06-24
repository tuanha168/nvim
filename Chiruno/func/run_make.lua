function _G.custom_complete_list(arglead, cmdline, cursorpos)
  Chiruno.print(arglead)
  Chiruno.print(cmdline)
  Chiruno.print(cursorpos)
  return { "first", "second", "third" }
end
Chiruno.run_make = function()
  vim.ui.input({ prompt = "Enter command", completion = "customlist,v:lua.custom_complete_list" }, function(makeCommand)
    if makeCommand == nil or makeCommand == "" then return end

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

    vim.o.makeprg = makeCommand
    vim.cmd "Make"
  end)
end
