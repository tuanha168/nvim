Chiruno.operatorfunc_lua = function(function_name)
  if function_name == nil then return end
  vim.go.operatorfunc = "v:lua.require'user.utils'." .. function_name
  vim.api.nvim_feedkeys("g@", "n", false)
end
