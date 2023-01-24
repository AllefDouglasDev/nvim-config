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
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'christoomey/vim-titlecase'
  use 'ThePrimeagen/harpoon'
  use 'eandrju/cellular-automaton.nvim'

  -- Tailwind
  use 'roobert/tailwindcss-colorizer-cmp.nvim'
  use 'NvChad/nvim-colorizer.lua'

  -- Colorscheme
  -- use 'morhetz/gruvbox'
  use 'ellisonleao/gruvbox.nvim'
  use 'joshdick/onedark.vim'
  use 'ayu-theme/ayu-vim'
  use 'Mofiqul/vscode.nvim'
  use 'AllefDouglasDev/visualstudiocpp.nvim'
  use 'lunarvim/darkplus.nvim'
  use 'folke/tokyonight.nvim'
  use 'wuelnerdotexe/vim-enfocado'
  use 'tomasr/molokai'

  -- Window Style
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'moll/vim-bbye'
  use 'akinsho/bufferline.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'goolord/alpha-nvim'
  use 'karb94/neoscroll.nvim'

  -- Tree
  use 'kyazdani42/nvim-tree.lua'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

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

  -- use({
  --   "glepnir/lspsaga.nvim",
  --   branch = "main",
  -- })

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
  use 'styled-components/vim-styled-components'
end)
