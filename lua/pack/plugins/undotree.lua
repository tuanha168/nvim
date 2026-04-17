vim.cmd [[packadd nvim.undotree]]

vim.keymap.set("n", "<C-y>", function() vim.cmd "Undotree" end, { silent = true })
