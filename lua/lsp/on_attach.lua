return function(client, bufnr) 
  if client.name == "eslint" then
    vim.b[bufnr].haveEslint = true
  end
end
