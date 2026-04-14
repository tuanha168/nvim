local M = {}

--- @param plugin string|table
--- @return table
local function to_spec_list(plugin)
  if type(plugin) == "table" and #plugin > 0 then
    return plugin
  end
  return { plugin }
end

--- Lazy-load a plugin via autocmd (fires once).
--- @param plugin string|table  URL string, {src=,version=} table, or list of specs
--- @param events string|string[]
--- @param callback fun()
--- @param opts? vim.api.keyset.create_autocmd
function M.on_event(plugin, events, callback, opts)
  local au_opts = vim.tbl_extend("force", { once = true }, opts or {})
  au_opts.callback = function()
    vim.pack.add(to_spec_list(plugin), { load = true })
    callback()
  end
  vim.api.nvim_create_autocmd(events, au_opts)
end

--- Lazy-load a plugin via a stub user command.
--- On first invocation: deregisters stub → pack.add → setup_fn → re-executes cmd.
--- @param plugin string|table  URL string, {src=,version=} table, or list of specs
--- @param cmd string
--- @param setup_fn? fun()
--- @param cmd_opts? vim.api.keyset.user_command
function M.on_command(plugin, cmd, setup_fn, cmd_opts)
  local opts = vim.tbl_extend("force", { desc = "lazy-load: " .. cmd }, cmd_opts or {})
  vim.api.nvim_create_user_command(cmd, function(info)
    vim.api.nvim_del_user_command(cmd)
    vim.pack.add(to_spec_list(plugin), { load = true })
    if setup_fn then setup_fn() end
    local call = cmd
    if info.range == 2 then
      call = info.line1 .. "," .. info.line2 .. call
    elseif info.range == 1 then
      call = info.line1 .. call
    end
    if info.args and info.args ~= "" then
      call = call .. " " .. info.args
    end
    vim.cmd(call)
  end, opts)
end

return M
