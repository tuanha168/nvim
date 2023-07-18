local ok, ft = pcall(require, "Comment.ft")
if ok then ft.dosini = { "# %s" } end

vim.keymap.set("v", "gc", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>gv")
