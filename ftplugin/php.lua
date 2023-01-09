local options_bo = {
  tabstop = 4,
  shiftwidth = 4,
}
for k, v in pairs(options_bo) do
  vim.bo[k] = v
end
