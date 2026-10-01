vim.api.nvim_create_user_command("TOhtml", function(info)
  vim.api.nvim_del_user_command "TOhtml"
  vim.cmd.packadd "nvim.tohtml"

  --- @type vim.api.keyset.cmd
  local command = { cmd = "TOhtml" }
  if info.range > 0 then command.range = { info.line1, info.line2 } end
  if info.args ~= "" then command.args = { info.args } end
  vim.api.nvim_cmd(command, {})
end, {
  bar = true,
  complete = "file",
  desc = "Lazy-load nvim.tohtml and export the current buffer",
  nargs = "?",
  range = "%",
})
