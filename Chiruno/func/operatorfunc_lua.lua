function Chiruno.func.operatorfunc_lua(function_name)
  if function_name == nil then return end
  vim.go.operatorfunc = "v:lua.Chiruno.motions." .. function_name
  vim.api.nvim_feedkeys("g@", "n", false)
end

return Chiruno.func.operatorfunc_lua
