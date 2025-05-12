return function(client, bufnr)
  if client.name == "eslint" or client.name == "eslintd" then vim.b[bufnr].haveEslint = true end
end
