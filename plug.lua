local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
-- packer.init({
-- 	display = {
-- 		open_fn = function()
-- 			return require("packer.util").float({ border = "rounded" })
-- 		end,
-- 	},
-- })

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("szw/vim-maximizer")
	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")
	use("williamboman/nvim-lsp-installer")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-compe")
	use("nvim-telescope/telescope.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("alaviss/nim.nvim")
	use("lewis6991/gitsigns.nvim")
	use("hoob3rt/lualine.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("ryanoasis/vim-devicons")
	use("TimUntersberger/neogit")
	use("sindrets/diffview.nvim")
	use("tomasr/molokai")
	use("kylechui/nvim-surround")
	use("itchyny/vim-gitbranch")
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")
	use("ap/vim-css-color")
	use("ray-x/lsp_signature.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("mattn/emmet-vim")
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("L3MON4D3/LuaSnip")
	use("nvim-treesitter/playground")
	use("EdenEast/nightfox.nvim")
	use("preservim/tagbar")
	use("jose-elias-alvarez/null-ls.nvim")
	-- use({
	-- 	"folke/which-key.nvim",
	-- 	config = function()
	-- 		require("which-key").setup({})
	-- 	end,
	-- })
	use("yegappan/mru")
	use("windwp/nvim-autopairs")
  use("ahmedkhalf/project.nvim")
  use("unblevable/quick-scope")
  use("gbprod/yanky.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
