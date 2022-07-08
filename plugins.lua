vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'szw/vim-maximizer'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'alaviss/nim.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'hoob3rt/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'
  use 'TimUntersberger/neogit'
  use 'sindrets/diffview.nvim'
  use 'tomasr/molokai'
  -- use { 'neoclide/coc.nvim', branch = 'release' }
  use 'tpope/vim-surround'
  use 'itchyny/vim-gitbranch'
  use { 'junegunn/fzf', run = '-> fzf#install()' }
  use 'junegunn/fzf.vim'
  use 'jiangmiao/auto-pairs'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'ap/vim-css-color'
  use 'ray-x/lsp_signature.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'mattn/emmet-vim'
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }
  -- use 'doki-theme/doki-theme-vim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
end)
