local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }
keymap('n', '<leader>v', ':e $MYVIMRC<CR>', opts)

-- szw/vim-maximizer
keymap('n', '<C-m>', ':MaximizerToggle!<CR>', opts)

-- Telescope
keymap('n', '<leader>fg', ':Telescope git_branches<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>', opts)
keymap('n', '<leader>ff', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>FF', ':Telescope grep_string<CR>', opts)
keymap('v', '<leader>FF', '"zy:Telescope grep_string default_text=<C-r>z<cr>', opts)

-- FZF
keymap('n', '<leader><space>', ':Files<CR>', opts)

-- Lsp Keymap
keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', 'gH', ':Telescope lsp_code_actions<CR>', opts)
keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('v', '<c-f>', '<ESC>vim.lsp.buf.range_formatting()<CR>', opts)
keymap('n', '<Leader><ESC><ESC>', ':tabclose<CR>', opts)

-- Window move
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- stay visual
keymap('n', '*', 'syiw<Esc>: let @/ = @s<CR>', {})

-- Git keymaps
keymap('n', '<leader>gg', ':Neogit<cr>', opts)
keymap('n', '<leader>gd', ':DiffviewOpen<cr>', opts)
keymap('n', '<leader>gD', ':DiffviewOpen main<cr>', opts)
keymap('n', '<leader>gl', ':Neogit log<cr>', opts)
keymap('n', '<leader>gp', ':Neogit push<cr>', opts)

-- Gitsigns
keymap('v', 'u', ':Gitsigns reset_hunk<CR>', {})
keymap("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", {})
keymap("n", "]c", "<cmd>Gitsigns next_hunk<CR>", {})

-- Vim move config
keymap("n", "J", ":m .+1<CR>", { silent = true, noremap = true })
keymap("n", "K", ":m .-2<CR>", { silent = true, noremap = true })
keymap("v", "J", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
keymap("v", "K", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })

-- switch buffers
keymap("n", "<S-Tab>", ":bp<CR>", { silent = true })
keymap("n", "<Tab>", ":bn<CR>", { silent = true })
keymap('n', '<c-w>', ':bd<CR>', opts)

-- Keep it center
keymap("n", "n", "nzzzv", {})
keymap("n", "<S-n>", "Nzzzv", {})

