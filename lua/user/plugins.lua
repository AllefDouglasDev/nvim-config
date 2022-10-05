vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- General
  use 'lewis6991/impatient.nvim'
  use 'tpope/vim-commentary'
  use 'alvan/vim-closetag'
  use 'tpope/vim-surround'
  use 'ap/vim-css-color'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'NTBBloodbath/rest.nvim'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'christoomey/vim-titlecase'
  use 'ThePrimeagen/harpoon'

  -- Colorscheme
  use 'morhetz/gruvbox'
  use 'joshdick/onedark.vim'
  use 'ayu-theme/ayu-vim'
  use 'Mofiqul/vscode.nvim'
  use 'AllefDouglasDev/visualstudiocpp.nvim'
  use 'lunarvim/darkplus.nvim'
  use 'folke/tokyonight.nvim'

  -- Window Style
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'moll/vim-bbye'
  use 'akinsho/bufferline.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'goolord/alpha-nvim'

  -- Nerdtree
  use 'scrooloose/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'tiagofumo/vim-nerdtree-syntax-highlight'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
  }

  -- Git
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- Tests
  use 'janko/vim-test'

  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'glepnir/lspsaga.nvim'

  -- Autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
end)
