return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  event = "BufRead",
  config = function()
    vim.keymap.set("n", "<C-y>", function() vim.cmd "UndotreeToggle" end, { silent = true })
  end,
}
