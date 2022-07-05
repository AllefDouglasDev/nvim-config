call plug#begin('~/.vim/plugged')
  " General
  Plug 'tpope/vim-commentary'
  Plug 'alvan/vim-closetag'
  Plug 'tpope/vim-surround'
  Plug 'ap/vim-css-color'
  " Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim' 
  Plug 'christoomey/vim-tmux-navigator'
  " Plug 'NTBBloodbath/rest.nvim'

  " Colorscheme
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'Mofiqul/vscode.nvim'
  " Plug 'overcache/NeoSolarized'
  Plug 'lunarvim/darkplus.nvim'
  " Plug 'sonph/onehalf', { 'rtp': 'vim' }

  " Window Style
  " Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'moll/vim-bbye'
  " Plug 'akinsho/bufferline.nvim'
  " Plug 'nvim-lualine/lualine.nvim'
  " Plug 'goolord/alpha-nvim'

  " Nerdtree
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  " Telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

  " Git
  Plug 'kdheepak/lazygit.nvim'
  Plug 'lewis6991/gitsigns.nvim'

  " Tests
  Plug 'janko/vim-test'
  
  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'

  " Autocomplete
  Plug 'honza/vim-snippets'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Plug 'hrsh7th/cmp-nvim-lsp'
  " Plug 'hrsh7th/cmp-buffer'
  " Plug 'hrsh7th/cmp-path'
  " Plug 'hrsh7th/cmp-cmdline'
  " Plug 'hrsh7th/nvim-cmp'
  " Plug 'hrsh7th/cmp-vsnip'
  " Plug 'hrsh7th/vim-vsnip'
  " Plug 'jose-elias-alvarez/null-ls.nvim'

call plug#end()
