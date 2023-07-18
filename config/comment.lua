local ok, ft = pcall(require, "Comment.ft")
if ok then ft.dosini = { "# %s" } end

vim.keymap.set("v", "gc", "gcgv")
