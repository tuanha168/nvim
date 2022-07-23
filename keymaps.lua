local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }
keymap("n", "<leader>v", ":e $MYVIMRC<CR>", opts)

-- Telescope
-- keymap("n", "<leader>fg", ":Telescope git_branches<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
-- keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
-- keymap("n", "<leader>ff", ":Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>FF", ":Telescope grep_string<CR>", opts)
-- keymap("v", "<leader>FF", '"zy:Telescope grep_string default_text=<C-r>z<cr>', opts)
-- local ignore = {
-- 	"**/target",
-- 	"**/vendor",
-- 	"**/node_modules",
-- 	"**/.git",
-- 	"**/dist",
-- 	"**/deploy",
-- 	"**/.idea",
-- 	"**/package-lock.json",
-- 	"**/yarn.lock",
-- }
-- local ign
-- for _, v in pairs(ignore) do
-- 	if not ign then
-- 		ign = v
-- 	else
-- 		ign = ign .. "," .. v
-- 	end
-- end
-- local find_file_command = ":lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--follow', '--no-ignore-vcs', '--hidden', '-g', '!{"
-- 	.. ign
-- 	.. "}' }})<CR>"
-- keymap("n", "<leader><space>", find_file_command, opts)

-- Window move
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- stay visual
-- keymap("n", "*", "syiw<Esc>: let @/ = @s<CR>", {})
keymap("n", "*", '"ayiwh/<c-r>a<CR>', { silent = true })
keymap("v", "*", '"ayh/<c-r>a<CR>', { silent = true })

-- Neogit
keymap("n", "<leader>gg", ":Neogit<cr>", opts)
keymap("n", "<leader>gd", ":DiffviewOpen<cr>", opts)
keymap("n", "<leader>gD", ":DiffviewOpen main<cr>", opts)
keymap("n", "<leader>gl", ":Neogit log<cr>", opts)
keymap("n", "<leader>gp", ":Neogit push<cr>", opts)

-- Gitsigns
keymap("v", "u", ":Gitsigns reset_hunk<CR>", {})
keymap("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", {})
keymap("n", "]c", "<cmd>Gitsigns next_hunk<CR>", {})
keymap("n", "G", "<cmd>Gitsigns diffthis<CR><C-l>", {})

-- Vim move config
keymap("n", "J", ":m .+1<CR>==", { silent = true, noremap = true })
keymap("n", "K", ":m .-2<CR>==", { silent = true, noremap = true })
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })

-- Visual indent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-- switch buffers
-- keymap("n", "<S-Tab>", ":bp<CR>", { silent = true })
-- keymap("n", "<Tab>", ":bn<CR>", { silent = true })
-- local function closeTab()
-- 	local status, _ = pcall(vim.cmd, "tabclose")
-- 	if not status then
-- 		pcall(vim.cmd, ":bd")
-- 	end
-- end
-- function CLOSE_TAB_OR_BUFFER()
-- 	if string.find(vim.api.nvim_buf_get_name(0), "Neogit") then
-- 		closeTab()
-- 	else
-- 		if vim.api.nvim_buf_get_name(0) ~= "" then
-- 			pcall(vim.cmd, ":bd")
-- 			if vim.api.nvim_buf_get_name(0) == "" then
-- 				closeTab()
-- 			end
-- 		else
-- 			closeTab()
-- 		end
-- 		if vim.api.nvim_buf_get_name(0) == "" then
-- 			pcall(vim.cmd, ":Alpha")
-- 			pcall(vim.cmd, ":bd#")
-- 		end
-- 	end
-- end
-- keymap("n", "<Leader><ESC><ESC>", "<cmd>lua CLOSE_TAB_OR_BUFFER()<CR>", opts)

-- Keep it center
keymap("n", "n", "nzzzv", {})
keymap("n", "<S-n>", "Nzzzv", {})
keymap("n", "j", "jzz", {})
keymap("n", "k", "kzz", {})
keymap("n", "L", "Lzz", opts)
keymap("n", "H", "Hzz", opts)

-- Console log shortcut
-- keymap("i", "cll", "console.log()<ESC><S-f>(a", {})
-- keymap("v", "cll", "S(iconsole.log<ESC>", {})
-- keymap("n", "cll", "yiwocll{<ESC>lp", {})

-- split and resize
-- keymap("n", '<C-up>', ':split', opts)
keymap("n", "<C-down>", ":split<CR>", opts)
keymap("n", "<C-right>", ":vsplit<CR>", opts)
keymap("n", "<up>", ":resize +2<CR>", opts)
keymap("n", "<down>", ":resize -2<CR>", opts)
keymap("n", "<left>", ":vertical resize -2<CR>", opts)
keymap("n", "<right>", ":vertical resize +2<CR>", opts)

-- tagbar
-- keymap("n", "-", ":TagbarToggle<CR><c-l>/", {})

-- close preview Window
keymap("n", "<CR>", "<CR>:ccl<CR>", { silent = true })

-- paste behavier
-- keymap("n", "p", "P==", { noremap = true, silent = true })
-- keymap("n", "P", "p==", { noremap = true, silent = true })

-- projects
keymap("n", "``", ":lua require'telescope'.extensions.project.project{}<CR>", { noremap = true, silent = true })

-- yanky
keymap("n", "p", "<Plug>(YankyPutAfter)", {})
keymap("n", "P", "<Plug>(YankyPutBefore)", {})
keymap("x", "p", "<Plug>(YankyPutAfter)", {})
keymap("x", "P", "<Plug>(YankyPutBefore)", {})
keymap("n", "gp", "<Plug>(YankyGPutAfter)", {})
keymap("n", "gP", "<Plug>(YankyGPutBefore)", {})
keymap("x", "gp", "<Plug>(YankyGPutAfter)", {})
keymap("x", "gP", "<Plug>(YankyGPutBefore)", {})
keymap("n", "<a-n>", "<Plug>(YankyCycleForward)", { silent = true })
keymap("n", "<a-p>", "<Plug>(YankyCycleBackward)", { silent = true })
