return {
  {
    "Curl",
    function()
      local servername = vim.v.servername
      local cmd = "curlcp " .. vim.fn.shellescape(servername)
      local output = vim.fn.system(cmd)
      Print(output)
    end,
  },
}
