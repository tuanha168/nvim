local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }
keymap('n', '<leader>v', ':e $MYVIMRC<CR>', opts)

-- szw/vim-maximizer
keymap('n', '<C-m>', ':MaximizerToggle!<CR>', opts)

-- keymap('n', '<leader><space>', ':Telescope git_files<CR>', opts)
-- keymap('n', '<leader>fd', ':lua telescope_find_files_in_path()<CR>', opts)
-- keymap('n', '<leader>fD', ':lua telescope_live_grep_in_path()<CR>', opts)
-- keymap('n', '<leader>ft', ':lua telescope_find_files_in_path("./tests")<CR>', opts)
-- keymap('n', '<leader>fT', ':lua telescope_live_grep_in_path("./tests")<CR>', opts)
-- keymap('n', '<leader>ff', ':Telescope live_grep<CR>', opts)
-- keymap('n', '<leader>fo', ':Telescope file_browser<CR>', opts)
-- keymap('n', '<leader>fn', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope git_branches<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>', opts)
keymap('n', '<leader>ff', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>FF', ':Telescope grep_string<CR>', opts)
keymap('v', '<leader>FF', '"zy:Telescope grep_string default_text=<C-r>z<cr>', opts)

-- FZF
keymap('n', '<leader><space>', ':Files<CR>', opts)

-- keymap('n', '<leader>ff', ':Rg<CR>', opts) 
keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap('n', 'gh', 'vim.lsp.buf.hover()<CR>', opts)
keymap('n', 'gH', '<cmd>:Telescope lsp_code_actions<CR>', opts)
keymap('n', 'gD', 'vim.lsp.buf.implementation()<CR>', opts)
keymap('n', '<c-k>', 'vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', 'gr', 'vim.lsp.buf.references()<CR>', opts)
keymap('n', 'gR', 'vim.lsp.buf.rename()<CR>', opts)
keymap('v', '<c-f>', '<ESC>vim.lsp.buf.range_formatting()<CR>', opts)
keymap('n', '<Leader><ESC><ESC>', ':tabclose<CR>', opts)
keymap('n', '<leader>gg', ':Neogit<cr>', opts)
keymap('n', '<leader>gd', ':DiffviewOpen<cr>', opts)
keymap('n', '<leader>gD', ':DiffviewOpen main<cr>', opts)
keymap('n', '<leader>gl', ':Neogit log<cr>', opts)
keymap('n', '<leader>gp', ':Neogit push<cr>', opts)

keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '*', 'syiw<Esc>: let @/ = @s<CR>', {})

keymap('v', 'u', ':Gitsigns reset_hunk<CR>', {})
keymap('x', 'K', ':move "<-2<CR>gv-gv', opts)
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('n', 'gn', ':bn<CR>', opts)
keymap('n', 'gp', ':bp<CR>', opts)
keymap('n', '<c-w>', ':bd<CR>', opts)

