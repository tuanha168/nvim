function Chiruno.operatorfunc_lua(function_name)
  if function_name == nil then return end
  vim.go.operatorfunc = "v:lua.require'user.Chiruno'." .. function_name
  vim.api.nvim_feedkeys("g@", "n", false)
end

return Chiruno.operatorfunc_lua
