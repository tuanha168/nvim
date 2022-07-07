call plug#begin()
  Plug 'szw/vim-maximizer'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
  \}
  Plug 'alaviss/nim.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
  Plug 'TimUntersberger/neogit'
  Plug 'sindrets/diffview.nvim'
  Plug 'projekt0n/github-nvim-theme'
  Plug 'vhyrro/neorg'
  Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-surround'
  Plug 'itchyny/vim-gitbranch'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ap/vim-css-color'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()
 
" default options
set completeopt=menu,menuone,noselect " better autocomplete options
set mouse=a " if I accidentally use the mouse
set splitright " splits to the right
set splitbelow " splits below
set expandtab " space characters instead of tab
set tabstop=2 " tab equals 2 spaces
set shiftwidth=2 " indentation
set number " show absolute line numbers
set relativenumber
set ignorecase " search case insensitive
set smartcase " search via smartcase
set incsearch " search incremental
set diffopt+=vertical " starts diff mode in vertical split
set hidden " allow hidden buffers
set nobackup " don't create backup files
set nowritebackup " don't create backup files
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
set signcolumn=yes " add a column for sings (e.g. LSP, ...)
set updatetime=520 " time until update
set undofile " persists undo tree
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set cmdheight=2
set cursorline

autocmd BufEnter * syntax sync fromstart

filetype plugin indent on " enable detection, plugins and indents
let mapleader = " " " space as leader key
let g:netrw_banner=0 " disable banner in netrw
let g:netrw_liststyle=3 " tree view in netrw
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript'] " syntax highlighting in markdown
nnoremap <leader>v :e $MYVIMRC<CR>
" lewis6991/gitsigns.nvim
lua << EOF
 require('gitsigns').setup {
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 0,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
 }
EOF

" szw/vim-maximizer
nnoremap <silent> <C-m> :MaximizerToggle!<CR>

" nnoremap <leader><space> :Telescope git_files<CR>
" nnoremap <leader>fd :lua telescope_find_files_in_path()<CR>
" nnoremap <leader>fD :lua telescope_live_grep_in_path()<CR>
" nnoremap <leader>ft :lua telescope_find_files_in_path("./tests")<CR>
" nnoremap <leader>fT :lua telescope_live_grep_in_path("./tests")<CR>
" " nnoremap <leader>ff :Telescope live_grep<CR>
" nnoremap <leader>fo :Telescope file_browser<CR>
" nnoremap <leader>fn :Telescope find_files<CR>
nnoremap <leader>fg :Telescope git_branches<CR>
nnoremap <leader>fb :Telescope buffers<CR>
" nnoremap <leader>fs :Telescope lsp_document_symbols<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
" nnoremap <leader>FF :Telescope grep_string<CR>

" FZF
nnoremap <leader><space> :Files<CR>
let $FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{**/target,**/vendor,**/node_modules,**/.git,**/dist,**/deploy,**/.idea,**/package-lock.json,**/yarn.lock}"'
" nnoremap <leader>ff :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0) 

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gH    <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
vnoremap <c-f> <ESC><cmd>lua vim.lsp.buf.range_formatting()<CR>
nnoremap <Leader><ESC><ESC> :tabclose<CR>

colorscheme molokai

" vhyrro/neorg
nnoremap <leader>nn :e ~/neorg/index.norg<CR>
lua << EOF
  require('neorg').setup {
            -- Tell Neorg what modules to load
            load = {
                ["core.defaults"] = {}, -- Load all the default modules
                ["core.norg.concealer"] = {}, -- Allows for use of icons
                ["core.norg.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            my_workspace = "~/neorg"
                        }
                    }
                }
            },
        }
EOF

" TimUntersberger/neogit and sindrets/diffview.nvim
lua << EOF
require("neogit").setup {
  disable_commit_confirmation = true,
  integrations = {
    diffview = true
    }
  }
EOF
nnoremap <leader>gg :Neogit<cr>
nnoremap <leader>gd :DiffviewOpen<cr>
nnoremap <leader>gD :DiffviewOpen main<cr>
nnoremap <leader>gl :Neogit log<cr>
nnoremap <leader>gp :Neogit push<cr>

" lua language server
lua << EOF
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- lspconfig
require("nvim-lsp-installer").setup {
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.intelephense.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.vuels.setup{}
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
EOF

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" delete_buffer Telescope
lua << EOF
require'telescope'.setup {
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    }
  }
}
EOF
vmap <silent> u :Gitsigns reset_hunk<CR>
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv
nnoremap gn :bn<cr>
nnoremap gp :bp<cr>
nnoremap <c-w> :bd<cr>
let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
autocmd FileType php setlocal commentstring=\/\/\ \ %s

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_c = '%t'
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = ''

" lsp_signature
lua << EOF
 cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
}

-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
EOF
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "javascript", "typescript", "vue", "scss", "regex", "php", "pug", "json", "html", "css", "tsx" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
