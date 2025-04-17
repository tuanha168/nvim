return function(client, bufnr) 
  if client.name == "eslint" then
    vim.bo[bufnr].haveEslint = true
  end
end
