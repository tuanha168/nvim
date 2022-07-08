local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }
keymap('n', '<leader>v', ':e $MYVIMRC<CR>', opts)

-- szw/vim-maximizer
keymap('n', '<silent> <C-m>', ':MaximizerToggle!<CR>', opts)

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
keymap('n', '<silent>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', '<silent>gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- keymap('n', '<silent>gH', '<cmd>:Telescope lsp_code_actions<CR>', opts)
keymap('n', '<silent>gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', '<silent><c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<silent> gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<silent> gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('v', '<c-f>', '<ESC><cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
keymap('n', '<Leader><ESC><ESC>', ':tabclose<CR>', opts)
keymap('n', '<leader>gg', ':Neogit<cr>', opts)
keymap('n', '<leader>gd', ':DiffviewOpen<cr>', opts)
keymap('n', '<leader>gD', ':DiffviewOpen main<cr>', opts)
keymap('n', '<leader>gl', ':Neogit log<cr>', opts)
keymap('n', '<leader>gp', ':Neogit push<cr>', opts)

-- vim.api.nvim_exec(([[
-- function! CheckBackspace() abort
-- let col = col('.') - 1
-- return !col || getline('.')[col - 1]  =~# '\s'
-- endfunction

-- inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
-- inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : CheckBackspace() ? "\<Tab>" : coc#refresh()
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
-- ]]), false)
-- Use `[g` and `]g` to navigate diagnostics
-- nmap <silent> [g <Plug>(coc-diagnostic-prev)
-- nmap <silent> ]g <Plug>(coc-diagnostic-next)
-- inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
-- noremap <C-h> <C-w>h
-- noremap <C-j> <C-w>j
-- noremap <C-k> <C-w>k
-- noremap <C-l> <C-w>l
-- nmap <silent> * "syiw<Esc>: let @/ = @s<CR>

-- vmap <silent> u :Gitsigns reset_hunk<CR>
-- xnoremap K :move '<-2<CR>gv-gv
-- xnoremap J :move '>+1<CR>gv-gv
-- nnoremap gn :bn<cr>
-- nnoremap gp :bp<cr>
-- nnoremap <c-w> :bd<cr>
