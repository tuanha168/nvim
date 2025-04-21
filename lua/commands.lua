return {
  {
    "Curl",
    function()
      local servername = vim.v.servername
      local cmd = "curlcp " .. vim.fn.shellescape(servername)
      vim.fn.system(cmd)
    end,
  },
}
