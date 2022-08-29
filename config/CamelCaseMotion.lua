local M = {}

M.setup = function()
  vim.keymap.set({ "x", "o" }, "iw", "<Plug>CamelCaseMotion_iw")
  vim.keymap.set({ "x", "o" }, "ib", "<Plug>CamelCaseMotion_ib")
  vim.keymap.set({ "x", "o" }, "ie", "<Plug>CamelCaseMotion_ie")
  vim.keymap.set("", "w", "<Plug>CamelCaseMotion_w")
  vim.keymap.set("", "b", "<Plug>CamelCaseMotion_b")
  vim.keymap.set("", "e", "<Plug>CamelCaseMotion_e")
  vim.keymap.set("", "ge", "<Plug>CamelCaseMotion_ge")
end

return M

